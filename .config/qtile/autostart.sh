#!/bin/bash
# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)

hostname=$(uname -n)

if [ "$hostname" = "work" ]; then
    /usr/lib/notification-daemon-1.0/notification-daemon &
    sleep 1
    $HOME/.config/escape_caps_toggle.sh &
    sleep 0.2
    $HOME/.config/keyboard_config.sh &
    setxkbmap us &
    emacs --daemon &
    nm-applet &
    thunar --daemon &
    picom -b &
    notify-send -t 2000 "autostart, found hostname: $hostname. Script continued."
    VBoxClient --clipboard &&
    VBoxClient --draganddrop
    xrandr --output Virtual-1 --mode 1920x1080; feh --bg-fill ~/Stack/Afbeeldingen/Wallpapers/default.jpg &
    syncthing &
fi

if [ "$hostname" = "linuxbox" ]; then
    setxkbmap us &
    /usr/lib/notification-daemon-1.0/notification-daemon &
    /usr/bin/emacs --daemon &
    nm-applet &
    sleep 1
    $HOME/.config/keyboard_config.sh &
    picom -b &
    syncthing &
    #signal-desktop --start-in-tray --use-tray-icon
    #$HOME/.config/stack_startup.sh & # Shell script to search for current Stack AppImage
fi

if [ "$hostname" = "thinkpad" ]; then
    $HOME/.config/escape_caps_toggle.sh &
    $HOME/.config/keyboard_config.sh &
    /usr/lib/notification-daemon-1.0/notification-daemon &
    setxkbmap us &
    emacs --daemon &
    nm-applet &
    thunar --daemon &
    picom -b &
    syncthing &
fi
