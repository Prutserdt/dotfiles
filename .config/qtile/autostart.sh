#!/bin/bash

# NOTE This file is generated from a README.org file. Do not alter this
# autostart.sh file directly and only modify the README.org file, then
# M-x and type 'org-babel-tangle' in emacs and press CTR MOD R to reload qtile.
# Happy hacking :-)

setxkbmap us &&
xmodmap $HOME/.config/kbswitch &&
xset r rate 300 80 &
picom -b &
/usr/bin/emacs --daeon &
