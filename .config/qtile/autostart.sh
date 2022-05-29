#!/bin/bash
# NOTE: This file is generated from the README.org file. Do not alter
# autostart.sh directly and only modify the README.org file in emacs by
# 'M-x' 'org-babel-tangle' and reload by 'M-x' 'doom/reload'

setxkbmap us &&
xmodmap $HOME/.config/kbswitch &&
xset r rate 300 80 &
picom -b &
/usr/bin/emacs --daemon &
