#!/bin/bash
#Check if Emacs is running
if pgrep -x "emacs" > /dev/null; then
   notify-send -t 60000 "Since emacs is already running, use emacsclient -c -n"
   emacsclient -c -n
else
   notify-send -t 60000 "Emacs is not running, starting the daemon followed by emacsclient"
   /usr/bin/emacs --daemon
   emacsclient -c -n
fi
