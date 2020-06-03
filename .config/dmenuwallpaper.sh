#!/bin/sh

# Script to change the wallpaper by dmenu
#ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -l 20 -fn unifont-08| awk '{print $1}'| xclip -selection clipboard && wal -i "$(xclip -o -selection clipboard)"
ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -l 20 -fn unifont-08| awk '{print $1}'| xclip -selection clipboard && feh --bg-center "$(xclip -o -selection clipboard)"
