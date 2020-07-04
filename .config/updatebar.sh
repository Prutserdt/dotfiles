#!/bin/sh
#~/.config/updatebar.sh
#                 _       _       _                    _
# _   _ _ __   __| | __ _| |_ ___| |__   __ _ _ __ ___| |__
#| | | | '_ \ / _` |/ _` | __/ _ \ '_ \ / _` | '__/ __| '_ \
#| |_| | |_) | (_| | (_| | ||  __/ |_) | (_| | | _\__ \ | | |
# \__,_| .__/ \__,_|\__,_|\__\___|_.__/ \__,_|_|(_)___/_| |_|
#      |_|                               Created by Prutserdt
#
# Outputs mute icon, master volume, date and time 
# This script is called after booting by another script: ~/.config/dwmbar.sh
# This script is also called after using volume/mute keys, see dwm config.h
mute="$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)].*/\1/")"
if [ $mute = "off" ]; then
xsetroot -name " 🔇`amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/"`% `date +"%d%h%y %H:%M"`"
else
xsetroot -name " 🔉`amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/"`% `date +"%d%h%y %H:%M"`"
fi
