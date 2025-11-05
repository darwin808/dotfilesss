#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
	VOLUME="$INFO"

	# Gruvbox colors
	COLOR_GREEN=0xffb8bb26  # Gruvbox green
	COLOR_YELLOW=0xfffabd2f # Gruvbox yellow
	COLOR_ORANGE=0xfffe8019 # Gruvbox orange
	COLOR_GRAY=0xff928374   # Gruvbox gray

	case "$VOLUME" in
	[6-9][0-9] | 100)
		ICON="􀊩"
		COLOR=$COLOR_GREEN
		;;
	[3-5][0-9])
		ICON="􀊧"
		COLOR=$COLOR_YELLOW
		;;
	[1-9] | [1-2][0-9])
		ICON="􀊥"
		COLOR=$COLOR_ORANGE
		;;
	*)
		ICON="􀊣"
		COLOR=$COLOR_GRAY
		;;
	esac

	sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%" background.color="$COLOR" icon.color=0xff282828 label.color=0xff282828
fi
