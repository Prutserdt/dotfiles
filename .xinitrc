#!/bin/sh
#
# ~/.xinitrc
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#                               
# Modified by Prutserdt
# Executed by startx. 
#
xmodmap ~/.Xmodmap & # Use .Xmodmap for escape/Caps_lock change and Super_R to mod3

# Set keyboard rate quicker
xset r rate 300 80

#
# Uncomment the next line to start i3wm and writes in the log:
# exec i3 -V >> ~/i3_log/i3log-$(date +'%F-%k-%M-%S') 2>&1

# Menu bar
~/.config/dwmbar.sh &
# Switch numlock on
numlockx &
# Set wallpaper
wal -i ~/Stack/Afbeeldingen/Wallpapers/wp2231064-3440x1440-wallpapers.jpg
# Run dwm, a sym link in  ~/bin, and the path was set in .bashrc
exec dwm
# if dwm exits 0, restart -- this allows hot reloading of config.h
while type dwm >/dev/null ; do dwm && continue || break ; done
# Run Vanilla dwm-6.2, ~/Stack/dwm/dwm-6.2_200512_vanilla
# exec dwm_vanilla
