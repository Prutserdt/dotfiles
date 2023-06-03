#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
currentBrightness=$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')
#echo $currentBrightness

if [[ "$currentBrightness" == "0.10" ]] ; then
    echo "niets doen, want grens van 0.1 bereikt"
    notify-send -t 60000 "🔆⚠ Brightness minimum reached!: ️" "$currentBrightness"
else
    newBrightness=$(echo $currentBrightness-0.1| bc -l)
    xrandr --output HDMI-2 --brightness $newBrightness # eDP-1 is the screen of my Thinkpad
    notify-send -t 60000 " 🔆 Brightness decreased to" "$newBrightness"
fi
