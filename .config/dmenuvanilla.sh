#!/bin/sh
# NOTE: This file is generated from the ~/.config/README.org file.
#       Please only edit that file and org-babel-tange (emacs)
echo -n "Are you sure you want to restore to vanilla dmenu and DELETE the current dmenu version? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/.config/suckless/dmenu &&
    mkdir ~/.config/suckless/dmenu &&
    cp -r ~/Stack/Dotfiles/dmenu/dmenu-4.9_vanilla/* ~/.config/suckless/dmenu &&
    cd ~/.config/suckless/dmenu &&
    clear && ls -al
else
    echo No
fi
