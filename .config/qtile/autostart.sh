#!/bin/bash
# Stuff to be run at startup.
xmodmap $HOME/.config/kbswitch && xset r rate 300 80 &
xmodmap $HOME/.config/rdxswitch && xset r rate 300 80 &
/usr/bin/emacs --daemon &
