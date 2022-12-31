#!/bin/sh
chosen=$(cat ~/Stack/Command_line/urls | dmenu -i -c -l 65)
[ -z "$chosen" ] && exit
xdg-open $chosen
