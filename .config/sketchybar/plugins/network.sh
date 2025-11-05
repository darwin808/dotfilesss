#!/bin/bash

# Get the primary network interface (usually en0 for WiFi)
INTERFACE=$(route -n get default 2>/dev/null | grep interface | awk '{print $2}')

# If no default route, try common interfaces
if [ -z "$INTERFACE" ]; then
    INTERFACE="en0"
fi

# Get network statistics (use fixed filename to persist between runs)
STATS_FILE="/tmp/sketchybar_net_stats"

# Function to get bytes for interface
get_bytes() {
    netstat -ibn | grep -m1 "^$INTERFACE" | awk '{print $7":"$10}'
}

# Get current bytes
CURRENT=$(get_bytes)
CURRENT_RX=$(echo "$CURRENT" | cut -d: -f1)
CURRENT_TX=$(echo "$CURRENT" | cut -d: -f2)

# Validate we got numbers
if ! [[ "$CURRENT_RX" =~ ^[0-9]+$ ]] || ! [[ "$CURRENT_TX" =~ ^[0-9]+$ ]]; then
    CURRENT_RX=0
    CURRENT_TX=0
fi

# Read previous values
if [ -f "$STATS_FILE" ]; then
    PREV=$(cat "$STATS_FILE")
    PREV_RX=$(echo "$PREV" | cut -d: -f1)
    PREV_TX=$(echo "$PREV" | cut -d: -f2)
    PREV_TIME=$(echo "$PREV" | cut -d: -f3)
else
    PREV_RX=0
    PREV_TX=0
    PREV_TIME=0
fi

# Save current values with timestamp
CURRENT_TIME=$(date +%s)
echo "$CURRENT_RX:$CURRENT_TX:$CURRENT_TIME" > "$STATS_FILE"

# Calculate time difference
TIME_DIFF=$((CURRENT_TIME - PREV_TIME))

# Avoid division by zero and handle first run
if [ "$TIME_DIFF" -le 0 ] || [ "$PREV_RX" -eq 0 ]; then
    DOWN_SPEED=0
    UP_SPEED=0
else
    # Calculate bytes per second
    DOWN_BYTES=$((CURRENT_RX - PREV_RX))
    UP_BYTES=$((CURRENT_TX - PREV_TX))

    # Make sure we don't have negative values (interface reset)
    if [ "$DOWN_BYTES" -lt 0 ]; then
        DOWN_BYTES=0
    fi
    if [ "$UP_BYTES" -lt 0 ]; then
        UP_BYTES=0
    fi

    DOWN_SPEED=$((DOWN_BYTES / TIME_DIFF))
    UP_SPEED=$((UP_BYTES / TIME_DIFF))
fi

# Format speeds for display
format_speed() {
    local bytes=$1
    if [ "$bytes" -ge 1048576 ]; then
        # MB/s
        local mb=$(echo "scale=1; $bytes/1048576" | bc)
        echo "${mb}MB/s"
    elif [ "$bytes" -ge 1024 ]; then
        # KB/s
        local kb=$(echo "scale=0; $bytes/1024" | bc)
        echo "${kb}KB/s"
    else
        # B/s
        echo "${bytes}B/s"
    fi
}

DOWN_LABEL=$(format_speed $DOWN_SPEED)
UP_LABEL=$(format_speed $UP_SPEED)

# Determine color based on total network activity (in bytes/s)
TOTAL_SPEED=$((DOWN_SPEED + UP_SPEED))

# Gruvbox colors based on network activity
COLOR_BLUE=0xff83a598      # Idle (< 100 KB/s)
COLOR_GREEN=0xffb8bb26     # Light (100KB - 1MB/s)
COLOR_YELLOW=0xfffabd2f    # Medium (1-10 MB/s)
COLOR_ORANGE=0xfffe8019    # Heavy (10-50 MB/s)
COLOR_RED=0xfffb4934       # Very heavy (> 50 MB/s)

if [ "$TOTAL_SPEED" -lt 102400 ]; then
    # < 100 KB/s
    COLOR=$COLOR_BLUE
elif [ "$TOTAL_SPEED" -lt 1048576 ]; then
    # < 1 MB/s
    COLOR=$COLOR_GREEN
elif [ "$TOTAL_SPEED" -lt 10485760 ]; then
    # < 10 MB/s
    COLOR=$COLOR_YELLOW
elif [ "$TOTAL_SPEED" -lt 52428800 ]; then
    # < 50 MB/s
    COLOR=$COLOR_ORANGE
else
    # >= 50 MB/s
    COLOR=$COLOR_RED
fi

# Update sketchybar with download and upload speeds
sketchybar --set "$NAME" \
    icon="􀙇" \
    label="↓$DOWN_LABEL ↑$UP_LABEL" \
    background.color="$COLOR" \
    icon.color=0xff282828 \
    label.color=0xff282828
