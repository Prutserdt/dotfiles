#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
#cat ~/.cache/dmenu_run | dmenu -i -c -l 65 | ${SHELL:-"/bin/sh"}
cat ~/.cache/dmenu_run | dmenu -c -bw 2 -l 40 -p 'run: ' | ${SHELL:-"/bin/sh"}
