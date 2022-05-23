#!/bin/bash

# NOTE This file is generated from a README.org file. Do not alter this
# config.py file directly and only modify the README.org file, then M-x and
# run: 'org-babel-tangle' in emacs and press CTR modL r to reload qtile live.

setxkbmap us &&
xmodmap $HOME/.config/kbswitch &&
xset r rate 300 80 &
picom -b &
/usr/bin/emacs --daeon &
