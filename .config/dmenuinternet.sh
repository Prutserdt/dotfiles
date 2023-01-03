#!/bin/sh
# Not to be edited directly. Please use ~/.config/README.org
chosen=$(cat ~/Stack/Command_line/urls | dmenu -i -c -l 65)
[ -z "$chosen" ] && exit
xdg-open $chosen
