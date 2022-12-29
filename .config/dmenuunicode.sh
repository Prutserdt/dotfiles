#!/bin/sh
	cat ~/.config/unicode | dmenu -i -c -l 45| awk '{print $1}'| xclip -selection clipboard &&
	xdotool key "ctrl+v" "BackSpace"
