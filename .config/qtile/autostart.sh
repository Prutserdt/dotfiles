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
