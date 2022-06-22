#!/bin/sh
#~/.config/ScreenshotToText.sh
#
# Magically fetch text from screen to clipboard
#
# make directory in ram memory of user
mkdir $XDG_RUNTIME_DIR/temp &
# Open screenshot tool and write to temp memory
xfce4-screenshooter -r -s $XDG_RUNTIME_DIR/temp/wismij.jpg &&
# Run tesseract on the screenshot, the filename will be wismij.txt
tesseract $XDG_RUNTIME_DIR/temp/wismij.jpg $XDG_RUNTIME_DIR/temp/wismij &&
# Write the ocr extracted text to the systems clipboard
cat  $XDG_RUNTIME_DIR/temp/wismij.txt | xclip -sel clip
