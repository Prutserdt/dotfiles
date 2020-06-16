#!/bin/sh
#~/.config/updatebar.sh
#                 _       _       _                    _
# _   _ _ __   __| | __ _| |_ ___| |__   __ _ _ __ ___| |__
#| | | | '_ \ / _` |/ _` | __/ _ \ '_ \ / _` | '__/ __| '_ \
#| |_| | |_) | (_| | (_| | ||  __/ |_) | (_| | | _\__ \ | | |
# \__,_| .__/ \__,_|\__,_|\__\___|_.__/ \__,_|_|(_)___/_| |_|
#      |_|                               Created by Prutserdt
#
# This shell script gives the master volume, date and time 
# and it is called by another script: ~/.config/dwmbar.sh
xsetroot -name " 🔉`amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/"`% `date +"%d%h%y %H:%M"`"
