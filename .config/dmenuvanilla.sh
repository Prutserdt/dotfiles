#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenuvanilla.sh" &&
echo -n "Are you sure you want to restore to vanilla dmenu and DELETE the current dmenu version? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/.config/suckless/dmenu &&
    mkdir ~/.config/suckless/dmenu &&
    cp -r ~/Stack/Dotfiles/dmenu/dmenu-distrotube_14JAN22/* ~/.config/suckless/dmenu &&
    cd ~/.config/suckless/dmenu &&
    clear && ls -al
    notify-send -t 60000 "The vanilla version of dmenu was restored. Please run sudo make clean instsall" &&
else
    echo No
    notify-send -t 60000 "Exited dmenuvanilla.sh. Nothing was changed. "
fi
