#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 1000 "Running dmenuinternet.sh" &&
chosen=$(cat $HOME/Stack/Command_line/urls | dmenu -c -bw 2 -l 40 -i -p 'Open website: ')
[ -z "$chosen" ] && exit
xdg-open $chosen &&
notify-send -t 1000 "Opening webpage: " "$chosen"
