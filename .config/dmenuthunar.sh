#!/bin/sh
# Not to be edited directly. Please use ~/.config/README.org
chosen=$(cat ~/Stack/Command_line/directories | dmenu -i -c -l 65)
[ -z "$chosen" ] && exit
thunar $chosen
