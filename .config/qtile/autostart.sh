#!/bin/bash
# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)
#+END_SRC

The us keyboard map is selected and my Alt/Super/Escape keys are changed. With ~xset~ the keyrepeats are increased. Picom is handling the transparancy and the Emacs daemon is started. nm-applet is the NetworkManager applet. Signal is also opened in the tray with the icon.
#+BEGIN_SRC sh :tangle autostart.sh :eval no :tangle-mode (identity #o755)
setxkbmap us &&
xmodmap $HOME/.config/kbswitch &&
$HOME/.config/notify-log.sh $HOME/.config/notify.log && # writing notification to a logfile
xset r rate 300 80 &
picom -b &
#/usr/bin/emacs --daemon &
emacs --daemon &
nm-applet &
#signal-desktop --start-in-tray --use-tray-icon &
#$HOME/.config/stack_startup.sh & # Shell script to search for current Stack AppImage
thunar --daemon &
## Next section is for virtual machines. Uncomment all below
## First a short break
#sleep .2 &&
## Then set the correct size of screen. Make sure screen is correct name and size.
#xrandr --output Virtual-1 --mode 1920x1080 &&
## Set the wallpaper
#feh --bg-scale ~/Stack/Afbeeldingen/Wallpapers/default.jpg & # Set wallpaper
