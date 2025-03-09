#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send  "Running dmenuwallpaper.sh" &&
ls $HOME/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -c -bw 2 -l 40 -i -p 'Wallpaper: ' | awk '{print $1}'| xclip -selection clipboard && feh --bg-fill "$(xclip -o -selection clipboard)" &&
notify-send -t 1000 "Wallpaper changed to: " "$(xclip -o -selection clipboard | cut -c 44-)"
