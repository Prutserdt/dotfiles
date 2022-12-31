#!/bin/sh
chosen=$(cat ~/Stack/Command_line/directories | dmenu -i -c -l 65)

[ -z "$chosen" ] && exit
thunar $chosen
