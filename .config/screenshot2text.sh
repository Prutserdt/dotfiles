#!/bin/sh
mkdir $XDG_RUNTIME_DIR/temp &
xfce4-screenshooter -r -s $XDG_RUNTIME_DIR/temp/wismij.jpg &&
tesseract $XDG_RUNTIME_DIR/temp/wismij.jpg $XDG_RUNTIME_DIR/temp/wismij &&
cat $XDG_RUNTIME_DIR/temp/wismij.txt | xclip -sel clip
