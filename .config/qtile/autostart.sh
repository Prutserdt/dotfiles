#!/bin/bash
# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (emacs)

setxkbmap us &&
xmodmap $HOME/.config/kbswitch &&
$HOME/.config/notify-log.sh $HOME/.config/notify.log && # writing notification to a logfile
xset r rate 300 80 &
picom -b &
/usr/bin/emacs --daemon &
nm-applet &
signal-desktop --start-in-tray --use-tray-icon &
$HOME/.config/stack_startup.sh & # Shell script to search for current Stack AppImage

## Next section is for virtual machines. Uncomment all below
## First a short break
#sleep .2 &&
## Then set the correct size of screen. Make sure screen is correct name and size.
#xrandr --output Virtual-1 --mode 1920x1080 &&
## Set the wallpaper
#feh --bg-scale ~/Stack/Afbeeldingen/Wallpapers/default.jpg & # Set wallpaper
