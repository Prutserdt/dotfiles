#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
ramdir="/dev/shm/temp"
mkdir $ramdir &
notify-send -t 60000 "Running screenshot2text" "Select an area with mouse 🐭 to convert to text" &&
screenshot_pic="$ramdir/wismij.jpg"
screenshot_txt="$ramdir/wismij"
xfce4-screenshooter -r -s $screenshot_pic &&
tesseract $screenshot_pic $screenshot_txt &&
cat $screenshot_txt | xclip -sel clip &&
notify-send -t 60000 "Text created from screenshot" "$(cat ${ramdir}/wismij.txt)"
