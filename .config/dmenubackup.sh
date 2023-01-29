#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenubackup.sh" &&
echo -n "Are you sure you want to make a backup of the current dmenu version? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable &&
    mkdir ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable &&
    cp -r ~/.config/suckless/dmenu/* ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable &&
    notify-send -t 60000 "Thank you. A backup of dmenu was made to"
else
    echo No
    notify-send -t 60000 "Exiting dmenubackup.sh" "No backup was made"
fi
