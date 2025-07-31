#!/bin/bash
# Get the hostname
hostname=$(uname -n)

# Check if Emacs process is running
if pgrep -x "emacs" > /dev/null; then
    notify-send -t 1000 "Since Emacs is already running, only starting emacsclient -c -n"
    emacsclient -c -n
else
    # Check the hostname and start Emacs accordingly
    if [[ "$hostname" == "work" || "$hostname" == "thinkpad" ]]; then
        notify-send -t 1000 "Emacs is not running, starting the daemon followed by emacsclient"
        #/usr/bin/emacs --daemon
        #emacsclient -c -n
        emacsclient -c -a "emacs" # Works on my thinkpad and Virtualbox image
    elif [[ "$hostname" == "linuxbox" ]]; then
        notify-send -t 1000 "Linuxbox. Emacs is not running, starting emacsclient"
        /usr/bin/emacs --daemon
        emacsclient -c -n
    fi
fi
