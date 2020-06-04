#!/bin/sh

# Script taken from Luke Smith github Voidrice and modified

# Get user selection via dmenu from emoji file.
# Requirement: dmenu and the center patch that gives the dmenu -c option.
chosen=$(cut -d ';' -f1 ~/.config/unicode | dmenu -i -c -l 30 | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, copy the emoji to the clipboard.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	echo "$chosen" | tr -d '\n' | xclip -selection clipboard &
fi
