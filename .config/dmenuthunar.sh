#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
chosen=$(cat ~/Stack/Command_line/directories | dmenu -c -bw 2 -l 40 -p 'Thunar open dir: ')
[ -z "$chosen" ] && exit
thunar $chosen
