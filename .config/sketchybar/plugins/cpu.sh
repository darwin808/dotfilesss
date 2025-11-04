#!/bin/sh

# Get CPU usage
CPU_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {print int(s)}')

sketchybar --set "$NAME" icon=󰻠 label="${CPU_USAGE}%"
