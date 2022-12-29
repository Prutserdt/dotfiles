#!/bin/sh
ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -c -l 30 | awk '{print $1}'| xclip -selection clipboard && feh --bg-center "$(xclip -o -selection clipboard)"
