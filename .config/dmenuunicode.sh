#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
cat ~/.config/unicode | dmenu -c -bw 2 -l 40 -p 'Emoji picker: '| awk '{print $1}'| xclip -selection clipboard &&
xdotool key "ctrl+v" "BackSpace" &&
notify-send -t 60000 "Emoji to clipboard: " "$(xclip -o -selection clipboard)"
