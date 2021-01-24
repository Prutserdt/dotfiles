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
~/.config/dwmbar.sh &   # Menu bar
numlockx &              # Switch numlock on
wal -i ~/Stack/Afbeeldingen/Wallpapers/wp2231064-3440x1440-wallpapers.jpg & # Set wallpaper
#picom -b               # Start picom, for transparancy
exec dwm                # Run dwm, a sym link in  ~/bin, and the path was set in .bashrc
while type dwm >/dev/null ; do dwm && continue || break ; done # to restart in place
#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
