#!/bin/bash
xmodmap -e "remove mod4 = Super_R"

case "$system_name" in
    archlinux)
        keycode=107
        ;;
    linuxbox)
        keycode=134
        ;;
    *)
        notify-send -t 60000 "Unknown system name: $system_name"
        exit 1
        ;;
esac

xmodmap -e "keycode $keycode = Super_R"
xmodmap -e "add mod3 = Super_R"
xmodmap -e "remove mod1 = Alt_R"
xmodmap -e "add mod5 = Alt_R"

xset r rate 300 80
