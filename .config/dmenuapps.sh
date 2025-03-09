#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
chosen=$(cat $HOME/.cache/dmenu_run | dmenu -c -bw 2 -l 40 -i -p 'run: ') &&
#notify-send "Starting application: " "$chosen" &&
notify-send -t 1000 "Starting application: " "$chosen" &&
$chosen
