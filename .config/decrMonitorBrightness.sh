#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
monitor=$(xrandr | awk '/ connected/ {print $1}')
currentBrightness=$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')
gamma_value=$(xrandr --verbose | awk '/^\s*Gamma:./ {print $NF}')
IFS=':' read -r gamma_r gamma_g gamma_b <<< "$gamma_value"
new_gamma_r=$(echo "1/$gamma_r" | bc -l)
new_gamma_g=$(echo "1/$gamma_g * 0.9" | bc -l)
new_gamma_b=$(echo "1/$gamma_b * 0.9" | bc -l)
new_gamma_value=$(printf "%.2f:%.2f:%.2f" "$new_gamma_r" "$new_gamma_g" "$new_gamma_b")
if [[ "$currentBrightness" == "0.10" ]] ; then
    echo "The current brightness is 0.1 and should not be any lower!"
    notify-send -t 60000 "🔆⚠ Brightness minimum reached!: ️" "$currentBrightness"
else
    newBrightness=$(echo $currentBrightness-0.1| bc -l)
    xrandr --output $monitor --brightness $newBrightness --gamma "$new_gamma_value"
    notify-send -t 60000 "🔆⚠ Brightness set to: $newBrightness RGB set to: $new_gamma_value"️
    echo "Brightness changed from $currentBrightness  to $newBrightness. RGB change from $gamma_value to $new_gamma_value"
fi
