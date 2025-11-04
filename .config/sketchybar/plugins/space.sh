#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# Gruvbox colors
YELLOW=0xfffabd2f

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" background.drawing=on background.color=$YELLOW icon.color=0xff282828
else
  sketchybar --set "$NAME" background.drawing=off icon.color=0xffebdbb2
fi
