#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)

# Get current key mappings
esc_key=$(xmodmap -pke | grep -P "keycode\s+9 =.+" | awk '{print $4}')
caps_lock_key=$(xmodmap -pke | grep -P "keycode\s+66 =.+" | awk '{print $4}')

# Toggle key mappings
if [ "$esc_key" == "Escape" ]; then
    # Right setting for redox (other way around)
    notify-send -t 60000 "Esc/Caps is swapped! Escape is now: $esc_key"
    xmodmap -e "remove lock = Caps_Lock"
    xmodmap -e 'keycode 9 = Caps_Lock'
    xmodmap -e 'keycode 66 = Escape'
    xmodmap -e 'add lock = Caps_Lock'
else
    # "Wrong" setting for my redox keyboard
    notify-send -t 60000 "Esc/Caps is swapped! Escape is now: $esc_key"
    xmodmap -e "remove lock = Caps_Lock"
    xmodmap -e 'keycode 9 = Escape'
    xmodmap -e 'clear lock'
    xmodmap -e 'keycode 66 = Caps_Lock'
    xmodmap -e 'add lock = Caps_Lock'
fi
