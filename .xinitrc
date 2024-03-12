#!/bin/sh
#
# ~/.xinitrc
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#          Modified by Prutserdt
# Executed by startx. 
#
xmodmap ~/.Xmodmap &    # Use .Xmodmap for escape/Caps_lock change and Super_R to mod3
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset r rate 300 80      # Move around quicker (increase keyboard rate)

numlockx &              # Switch numlock on
feh --bg-scale ~/Stack/Afbeeldingen/Wallpapers/default.jpg & # Set wallpaper
exec qtile start
