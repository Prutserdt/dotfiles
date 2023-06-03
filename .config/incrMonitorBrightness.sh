#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
currentBrightness=$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')
echo $currentBrightness
if [[ "$currentBrightness" == "1.0" ]] ; then
     echo "niets doen, want grens van 1.0 bereikt"
     notify-send -t 60000 "🔆⚠ Brightness maximum reached!⚠️ No need to increase further!🤓"
else
    newBrightness=$(echo $currentBrightness+0.1| bc -l)
    xrandr --output HDMI-2 --brightness $newBrightness # eDP-1 for Thinkpad laptop
    notify-send -t 60000 "🔆 Brightness increased to" "$newBrightness"
fi
