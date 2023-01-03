#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tange (emacs)
mkdir $XDG_RUNTIME_DIR/temp &
xfce4-screenshooter -r -s $XDG_RUNTIME_DIR/temp/wismij.jpg &&
tesseract $XDG_RUNTIME_DIR/temp/wismij.jpg $XDG_RUNTIME_DIR/temp/wismij &&
cat $XDG_RUNTIME_DIR/temp/wismij.txt | xclip -sel clip
