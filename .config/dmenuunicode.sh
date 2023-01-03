#!/bin/sh
# NOTE: This file is generated from the ~/.config/README.org file.
#       Please only edit that file and org-babel-tange (emacs)
cat ~/.config/unicode | dmenu -i -c -l 65| awk '{print $1}'| xclip -selection clipboard &&
xdotool key "ctrl+v" "BackSpace"
