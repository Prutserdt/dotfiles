#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenuinternet.sh" &&
chosen=$(cat ~/Stack/Command_line/urls | dmenu -c -bw 2 -l 40 -p 'Open website: ')
[ -z "$chosen" ] && exit
xdg-open $chosen &&
notify-send -t 60000 "Opening webpage: " "$chosen"
