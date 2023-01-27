#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
mkdir $XDG_RUNTIME_DIR/temp &
notify-send  "Help for screenshot2text" "Select an area which to convert to text with the mouse"
xfce4-screenshooter -r -s $XDG_RUNTIME_DIR/temp/wismij.jpg &&
tesseract $XDG_RUNTIME_DIR/temp/wismij.jpg $XDG_RUNTIME_DIR/temp/wismij &&
cat $XDG_RUNTIME_DIR/temp/wismij.txt | xclip -sel clip &&
notify-send -t 60000 "Text created from screenshot" "$(cat $XDG_RUNTIME_DIR/temp/wismij.txt)"
