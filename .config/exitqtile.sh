#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send "Really! Are you trying to kill me? 😢"
echo -n "Do you wish to exit qtile right now? (y/n) "

read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
   killall qtile
else
    echo No
fi

notify-send "Killing Qtile right now...."
