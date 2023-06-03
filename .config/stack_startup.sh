#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
# The following is opening my current Stack AppImage.
dir="$HOME/Applications" # directory
# Search for .AppImage files containing "stack" in their name
appimage=$(find "$dir" -name "*stack*.AppImage" -print -quit)
# Check if an appropriate file was found
if [ -n "$appimage" ]; then
#    chmod +x "$appimage"
    notify-send -t 6000 "Starting the Stack .AppImage..." && #send notification
    "$appimage"  # Execute the file
else
    notify-send -t 6000 "No .AppImage file containing 'stack' in its name was found in $dir"
fi
