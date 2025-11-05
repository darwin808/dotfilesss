#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
	exit 0
fi

# Gruvbox colors
COLOR_GREEN=0xffb8bb26  # Gruvbox green
COLOR_YELLOW=0xfffabd2f # Gruvbox yellow
COLOR_ORANGE=0xfffe8019 # Gruvbox orange
COLOR_RED=0xfffb4934    # Gruvbox red

case "${PERCENTAGE}" in
9[0-9] | 100)
	ICON="􀛨"
	COLOR=$COLOR_GREEN
	;;
[6-8][0-9])
	ICON="􀺸"
	COLOR=$COLOR_GREEN
	;;
[3-5][0-9])
	ICON="􀺶"
	COLOR=$COLOR_YELLOW
	;;
[1-2][0-9])
	ICON="􀛩"
	COLOR=$COLOR_ORANGE
	;;
*)
	ICON="􀛩"
	COLOR=$COLOR_RED
	;;
esac

if [[ "$CHARGING" != "" ]]; then
	ICON="􀢋"
	COLOR=$COLOR_GREEN
fi

# Update the item with icon, label, and background color
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" background.color="$COLOR" icon.color=0xff282828 label.color=0xff282828
