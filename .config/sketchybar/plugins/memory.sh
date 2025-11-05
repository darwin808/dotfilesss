#!/bin/bash

# Get memory usage on macOS
MEMORY_USAGE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5}' | sed 's/%//')

# If memory_pressure doesn't work, use vm_stat as fallback
if [ -z "$MEMORY_USAGE" ]; then
  # Get memory info from vm_stat
  PAGE_SIZE=$(pagesize)
  VM_STAT=$(vm_stat)

  FREE_PAGES=$(echo "$VM_STAT" | grep "Pages free" | awk '{print $3}' | tr -d '.')
  INACTIVE_PAGES=$(echo "$VM_STAT" | grep "Pages inactive" | awk '{print $3}' | tr -d '.')
  SPECULATIVE_PAGES=$(echo "$VM_STAT" | grep "Pages speculative" | awk '{print $3}' | tr -d '.')
  WIRED_PAGES=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | tr -d '.')
  ACTIVE_PAGES=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | tr -d '.')

  FREE_MEM=$(echo "($FREE_PAGES + $INACTIVE_PAGES + $SPECULATIVE_PAGES) * $PAGE_SIZE / 1024 / 1024 / 1024" | bc -l)
  USED_MEM=$(echo "($WIRED_PAGES + $ACTIVE_PAGES) * $PAGE_SIZE / 1024 / 1024 / 1024" | bc -l)
  TOTAL_MEM=$(echo "$FREE_MEM + $USED_MEM" | bc -l)

  MEMORY_USAGE=$(printf "%.0f" $(echo "$USED_MEM / $TOTAL_MEM * 100" | bc -l))
fi

# Gruvbox colors for dynamic memory usage (using aqua/green spectrum)
COLOR_AQUA=0xff8ec07c     # Low usage (0-40%)
COLOR_GREEN=0xffb8bb26    # Medium usage (41-65%)
COLOR_YELLOW=0xfffabd2f   # High usage (66-80%)
COLOR_ORANGE=0xfffe8019   # Very high usage (81-90%)
COLOR_RED=0xfffb4934      # Critical usage (91-100%)

ICON="􀫦"

# Determine color based on memory usage
if [ "$MEMORY_USAGE" -le 40 ]; then
    COLOR=$COLOR_AQUA
elif [ "$MEMORY_USAGE" -le 65 ]; then
    COLOR=$COLOR_GREEN
elif [ "$MEMORY_USAGE" -le 80 ]; then
    COLOR=$COLOR_YELLOW
elif [ "$MEMORY_USAGE" -le 90 ]; then
    COLOR=$COLOR_ORANGE
else
    COLOR=$COLOR_RED
fi

sketchybar --set "$NAME" icon="$ICON" label="$MEMORY_USAGE%" background.color="$COLOR" icon.color=0xff282828 label.color=0xff282828
