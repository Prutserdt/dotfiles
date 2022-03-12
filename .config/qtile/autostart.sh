#!/bin/bash

# NOTE This file is generated from a README.org file. Do not alter this
# autostart.sh file directly and only modify the REAME.org file, then
# Alt-x and type: # 'org-babel-tangle' in emacs and run 'doom sync' in
# the terminal. Happy hacking :-)

xmodmap $HOME/.config/kbswitch && xset r rate 300 80 &
xmodmap $HOME/.config/rdxswitch && xset r rate 300 80 &
picom -b &
/usr/bin/emacs --daemon &
