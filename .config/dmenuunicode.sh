#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenuunicode.sh" &&
cat $HOME/.config/unicode | dmenu -c -bw 2 -l 40 -i -p 'Emoji picker: '| awk '{print $1}'| xclip -selection clipboard &&
xdotool key "ctrl+v" "BackSpace" &&
notify-send -t 60000 "Emoji in clipboard: " "$(xclip -o -selection clipboard)"
