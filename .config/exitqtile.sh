#!/bin/bash
# NOTE: This file is generated from the ~/.config/README.org file.
#       Please only edit that file and org-babel-tange (emacs)
echo -n "Do you wish to exit qtile right now? (y/n) "


read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
   killall qtile
else
    echo No
fi
