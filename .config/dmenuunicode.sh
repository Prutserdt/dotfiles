#!/bin/sh
# Not to be edited directly. Please use ~/.config/README.org
cat ~/.config/unicode | dmenu -i -c -l 65| awk '{print $1}'| xclip -selection clipboard &&
xdotool key "ctrl+v" "BackSpace"
