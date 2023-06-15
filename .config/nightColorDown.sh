#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
gamma_value=$(xrandr --verbose | awk '/^\s*Gamma:./ {print $NF}')
echo "Gamma value: $gamma_value is currently used"
IFS=':' read -r gamma_r gamma_g gamma_b <<< "$gamma_value"
new_gamma_r=$(echo "1/$gamma_r" | bc -l)
new_gamma_g=$(echo "1/$gamma_g * 1.1" | bc -l)
new_gamma_b=$(echo "1/$gamma_b * 1.1" | bc -l)
new_gamma_value=$(printf "%.2f:%.2f:%.2f" "$new_gamma_r" "$new_gamma_g" "$new_gamma_b")
xrandr --output $(xrandr | awk '/ connected/ {print $1}') --gamma "$new_gamma_value"
echo "New gamma value, after xrandr: $new_gamma_value"
notify-send -t 60000 "🔆⚠ Red decreased to: " "$new_gamma_value"️
