#!/bin/bash

# Get number of CPU cores
CORE_COUNT=$(sysctl -n hw.ncpu)

# Get CPU usage percentage (average across all cores)
CPU_USAGE=$(ps -A -o %cpu | awk -v cores="$CORE_COUNT" '{s+=$1} END {printf "%.0f", s/cores}')

# Gruvbox colors for dynamic CPU usage (using purple spectrum)
COLOR_PURPLE=0xffd3869b   # Low usage (0-25%)
COLOR_BLUE=0xff83a598     # Medium usage (26-50%)
COLOR_YELLOW=0xfffabd2f   # High usage (51-75%)
COLOR_ORANGE=0xfffe8019   # Very high usage (76-90%)
COLOR_RED=0xfffb4934      # Critical usage (91-100%)

ICON="􀐱"

# Determine color based on CPU usage
if [ "$CPU_USAGE" -le 25 ]; then
    COLOR=$COLOR_PURPLE
elif [ "$CPU_USAGE" -le 50 ]; then
    COLOR=$COLOR_BLUE
elif [ "$CPU_USAGE" -le 75 ]; then
    COLOR=$COLOR_YELLOW
elif [ "$CPU_USAGE" -le 90 ]; then
    COLOR=$COLOR_ORANGE
else
    COLOR=$COLOR_RED
fi

sketchybar --set "$NAME" icon="$ICON" label="$CPU_USAGE%" background.color="$COLOR" icon.color=0xff282828 label.color=0xff282828
