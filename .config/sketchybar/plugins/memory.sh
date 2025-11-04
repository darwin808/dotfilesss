#!/bin/sh

# Get memory usage
MEMORY_USED=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5}' | cut -d'.' -f1)

# If the above doesn't work, try this alternative method
if [ "$MEMORY_USED" = "" ]; then
  # Get memory stats from vm_stat
  PAGE_SIZE=$(pagesize)
  PAGES_FREE=$(vm_stat | grep "Pages free" | awk '{print $3}' | tr -d '.')
  PAGES_ACTIVE=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
  PAGES_INACTIVE=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | tr -d '.')
  PAGES_SPECULATIVE=$(vm_stat | grep "Pages speculative" | awk '{print $3}' | tr -d '.')
  PAGES_WIRED=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | tr -d '.')

  FREE_MEM=$((PAGES_FREE * PAGE_SIZE / 1024 / 1024))
  ACTIVE_MEM=$((PAGES_ACTIVE * PAGE_SIZE / 1024 / 1024))
  WIRED_MEM=$((PAGES_WIRED * PAGE_SIZE / 1024 / 1024))

  TOTAL_MEM=$((FREE_MEM + ACTIVE_MEM + WIRED_MEM))
  USED_MEM=$((ACTIVE_MEM + WIRED_MEM))

  if [ "$TOTAL_MEM" -gt 0 ]; then
    MEMORY_USED=$((USED_MEM * 100 / TOTAL_MEM))
  else
    MEMORY_USED=0
  fi
fi

sketchybar --set "$NAME" icon=󰘚 label="${MEMORY_USED}%"
