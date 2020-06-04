#!/bin/sh

# Script to change the wallpaper by dmenu
# This required the dmenu patch: center, which gives the dmenu -c option.
ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -c -l 20 | awk '{print $1}'| xclip -selection clipboard && feh --bg-center "$(xclip -o -selection clipboard)"
