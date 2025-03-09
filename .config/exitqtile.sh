#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 1000 "Do you want to leave the system?"
choices=("Close Window Manager" "Reboot" "Shutdown")
colors="-nb #FFFFFF -nf #000000 -sb #DC5A5A -sf  #FFFFFF"  # Pale red background outside, red inside
chosen=$(printf '%s\n' "${choices[@]}" | dmenu -c -l "${#choices[@]}" $colors)


case "$chosen" in
    "Close Window Manager")
        # Command to close the window manager (qtile in this case)
        killall qtile
        notify-send -t 1000 "Closing down qtile!"
        ;;
    "Reboot")
        # Command to reboot the system
        systemctl reboot
        notify-send -t 1000 "Rebooting the system!"
        ;;
    "Shutdown")
        # Command to shut down the system
        systemctl poweroff
        notify-send -t 1000 "Shutting down the system!"
        ;;
    *)
        echo "No option selected."
        ;;
esac
