#!/bin/sh
# This shell script gives the master volume, date and time 
# and it is called by another script: ~/.config/dwmbar.sh
xsetroot -name " 🔉`amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/"`% `date +"%d%h%y %H:%M"`"
