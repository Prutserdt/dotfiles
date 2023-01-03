#!/bin/sh
# Not to be edited directly. Please use ~/.config/README.org
ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -c -l 65 | awk '{print $1}'| xclip -selection clipboard && feh --bg-center "$(xclip -o -selection clipboard)"
