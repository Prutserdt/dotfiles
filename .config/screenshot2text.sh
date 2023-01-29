#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
mkdir $XDG_RUNTIME_DIR/temp &
notify-send -t 60000 "Running screenshot2text" "Select an area with mouse 🐭 to convert to text" &&
xfce4-screenshooter -r -s $XDG_RUNTIME_DIR/temp/wismij.jpg &&
tesseract $XDG_RUNTIME_DIR/temp/wismij.jpg $XDG_RUNTIME_DIR/temp/wismij &&
cat $XDG_RUNTIME_DIR/temp/wismij.txt | xclip -sel clip &&
notify-send -t 60000 "Text created from screenshot" "$(cat $XDG_RUNTIME_DIR/temp/wismij.txt)"
