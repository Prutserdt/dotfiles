#!/bin/bash
# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)

setxkbmap us &&
xmodmap $HOME/.config/kbswitch &&
$HOME/.config/notify-log.sh $HOME/.config/notify.log && # writing notification to a logfile
xset r rate 300 80 &
picom -b &
emacs --daemon &
nm-applet &
thunar --daemon &
#signal-desktop --start-in-tray --use-tray-icon &
#$HOME/.config/stack_startup.sh & # Shell script to search for current Stack AppImage
## Next section is for my virtual machine. Uncomment all below
#sleep .2 &&
#xrandr --output Virtual-1 --mode 1920x1080 &&
#feh --bg-fill ~/Stack/Afbeeldingen/Wallpapers/wp4831363-retro-sunset-wallpapers.jpg &
#/usr/bin/emacs --daemon &
#sleep .2 &&
#VboxClient --clipboard &&
#VboxClient --draganddrop &&
