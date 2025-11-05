#!/bin/sh
# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# Gruvbox colors
GRUVBOX_ORANGE=0xffb8bb26 # Gruvbox bright orange

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" background.color=$GRUVBOX_ORANGE \
    icon.color=0xff282828 \
    background.drawing=on
else
  sketchybar --set "$NAME" icon.color=0xffebdbb2 \
    background.drawing=off
fi
