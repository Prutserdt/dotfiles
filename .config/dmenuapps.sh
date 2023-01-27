#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
#cat ~/.cache/dmenu_run | dmenu -c -bw 2 -l 40 -p 'run: ' | ${SHELL:-"/bin/sh"} &
chosen=$(cat ~/.cache/dmenu_run | dmenu -c -bw 2 -l 40 -p 'run: ') &&
notify-send -t 6000 "Starting application: " "$chosen" &&
$chosen
