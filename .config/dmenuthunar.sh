#!/bin/sh

# Script to open direcotry in Thunar by dmenu
# This required the dmenu patch: center, which gives the dmenu -c option.
cat ~/.config/directories | dmenu -i -c -l 30 | awk '{print $1}'| xclip -selection clipboard && thunar "$(xclip -o -selection clipboard)"
