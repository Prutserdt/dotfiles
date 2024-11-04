#!/bin/bash

notify-send -t 60000 "script gestart... als ik dit lees gaat iets mis...."
# Get the hostname
hostname=$(uname -n)

# Check if Emacs process is running
if pgrep -x "emacs" > /dev/null; then
    notify-send -t 60000 "Since Emacs is already running, only starting emacsclient -c -n"
    emacsclient -c -n
else
    # Check the hostname and start Emacs accordingly
    if [[ "$hostname" == "work" || "$hostname" == "thinkpad" ]]; then
        notify-send -t 60000 "Emacs is not running, starting the daemon followed by emacsclient"
        #/usr/bin/emacs --daemon
        #emacsclient -c -n
        emacsclient -c -a "emacs" # Works on my thinkpad and Virtualbox image
    elif [[ "$hostname" == "linuxbox" ]]; then
        #FIXME: dit werkt op mijn linuxbox, /usr/bin/emacs
        notify-send -t 60000 "Linuxbox. Emacs is not running, starting emacsclient"
        /usr/bin/emacs
        #emacsclient -c -n        # Works on my desktop
    fi
fi
