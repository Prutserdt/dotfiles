#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
xrandr --output $(xrandr | awk '/ connected/ {print $1}') --gamma 1:1:1
notify-send -t 60000 "🔆 RGB reset!"
