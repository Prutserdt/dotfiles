#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tange (emacs)
chosen=$(cat ~/Stack/Command_line/urls | dmenu -i -c -l 65)
[ -z "$chosen" ] && exit
xdg-open $chosen
