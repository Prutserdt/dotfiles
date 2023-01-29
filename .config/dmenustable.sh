#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenustable" &&
echo -n "Are you sure you want to restore to the stable version and DELETE the current dmenu version? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/.config/suckless/dmenu &&
    mkdir ~/.config/suckless/dmenu &&
    cp -r ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable/* ~/.config/suckless/dmenu &&
    cd ~/.config/suckless/dmenu &&
    clear && ls -al
    notify-send -t 60000 "The stable version of dmenu was placed back" "Please run sudo make clean install"
else
    echo No
    notify-send -t 60000 "Exited dmenustable.sh. Nothing was changed"
fi
