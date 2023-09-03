#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send -t 60000 "Running dmenupatch.sh" &&
echo -n "Are you sure you want to patch the current dmenu version? This will first:
RESTORE TO THE STABLE VERSION OF DMENU and after that make clean install on the .diff file in the direcotory ~/Stack/Dotfiles/dmenu/patches/test. Yes or no? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r $HOME/.config/suckless/dmenu &&
    mkdir $HOME/.config/suckless/dmenu &&
    cp -r $HOME/Stack/Dotfiles/dmenu/dmenu-4.9_stable/* ~/.config/suckless/dmenu &&
    cd $HOME/.config/suckless/dmenu &&
    clear && ls -al
    ls $HOME/Stack/Dotfiles/dmenu/patches/test/*.diff >> ~/.config/suckless/dmenu/log/diff_log &&
    cp -r $HOME/.config/suckless/dmenu/config.h ~/.config/suckless/dmenu/config.def.h &&
    rm $HOME/.config/suckless/dmenu/config.h &&
    patch -p1 < $HOME/Stack/Dotfiles/dmenu/patches/test/*.diff &&
    make clean install
    notify-send -t 60000 "dmenu was patched"
else
    echo No
    notify-send -t 60000 "Exited dmenupatch.sh. Nothing was changed"
fi
