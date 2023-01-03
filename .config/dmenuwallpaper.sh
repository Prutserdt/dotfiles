#!/bin/sh
# NOTE: This file is generated from the ~/.config/README.org file.
#       Please only edit that file and org-babel-tange (emacs)
ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -c -l 65 | awk '{print $1}'| xclip -selection clipboard && feh --bg-center "$(xclip -o -selection clipboard)"
