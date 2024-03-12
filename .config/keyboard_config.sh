#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)

hostname=$(uname -n)

# Remove Super_R key from mod4 modifier
xmodmap -e "remove mod4 = Super_R"

# Select keycode for Super_R based on hostname
case "$hostname" in
    work)
        keycode=107    # Use keycode 107 for work system... to be tested!!! should not work
        notify-send -t 60000 "keyboard-config.sh script, found hostname: $hostname. Script continued."
        ;;
    linuxbox)
        keycode=134    # Use keycode 134 for linuxbox system
        notify-send -t 60000 "keyboard-config.sh script, found hostname: $hostname. Script continued."
        ;;
    thinkpad)
        keycode=107    # Use keycode 107 for thinkpad system, this is the printscreen button :-)
        notify-send -t 60000 "keyboard-config.sh script, found hostname: $hostname. Script continued."
        ;;
    *)
        # Display a notification for unknown hostnames and exit with an error
        notify-send -t 60000 "Unknown hostname: $hostname"
        exit 1
        ;;
esac

# Map the selected keycode to Super_R and add it to mod3 modifier
xmodmap -e "keycode $keycode = Super_R"
xmodmap -e "add mod3 = Super_R"

# Remove Alt_R from mod1 modifier and add it to mod5
xmodmap -e "remove mod1 = Alt_R"
xmodmap -e "add mod5 = Alt_R"

# Set key auto-repeat rate to 300 delay and 80 rate
xset r rate 300 80
