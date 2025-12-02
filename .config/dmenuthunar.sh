#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 1000 "Running dmenu-pcmanfm.sh" &&
chosen=$(cat $HOME/Stack/Command_line/directories | dmenu -c -bw 2 -l 40 -i -p 'PCManFM open dir: ')
[ -z "$chosen" ] && exit
notify-send -t 1000 "Directory opened in PCManFM: " "$chosen" &&
#pcmanfm "$chosen"
env GTK_THEME=Adwaita:dark pcmanfm "$chosen" # Forcing the dark theme
