#!/bin/sh
chosen=$(cat ~/.config/urls | dmenu -i -c -l 65)
[ -z "$chosen" ] && exit
	brave $chosen
