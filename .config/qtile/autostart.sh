#!/bin/bash
# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)

$HOME/.config/escape_caps_toggle.sh &
$HOME/.config/keyboard_config.sh &
setxkbmap us &
$HOME/.config/notify-log.sh $HOME/.config/notify.log & # writing notification to a logfile
emacs --daemon &
nm-applet &
thunar --daemon &
picom -b &
#signal-desktop --start-in-tray --use-tray-icon &
#$HOME/.config/stack_startup.sh & # Shell script to search for current Stack AppImage

## Next section is hostname dependent.
if [ "$HOSTNAME" = "work" ]; then
    VboxClient --clipboard &&
    VboxClient --draganddrop
fi
## xrandr --output Virtual-1 --mode 1920x1080 &&
