#!/bin/sh
xsetroot -name " 🔉`amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/"`% `date +"%d%h%y %H:%M"`"
