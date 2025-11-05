#!/bin/sh

# Gruvbox yellow color
COLOR_YELLOW=0xfffabd2f

ICON="􀐫"

sketchybar --set "$NAME" icon="$ICON" label="$(date '+%d/%m %H:%M')" icon.color=0xff282828 label.color=0xff282828
