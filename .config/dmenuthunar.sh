#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenuthunar.sh" &&
chosen=$(cat ~/Stack/Command_line/directories | dmenu -c -bw 2 -l 40 -p 'Thunar open dir: ')
[ -z "$chosen" ] && exit
notify-send -t 60000 "Directory opened in Thunar: " "$chosen" &&
thunar $chosen
