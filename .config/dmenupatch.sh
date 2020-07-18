#!/bin/bash
# ~/.config/dmenupatch.sh
#     _                                        _       _           _
#  __| |_ __ ___   ___ _ __  _   _ _ __   __ _| |_ ___| |__    ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | | '_ \ / _` | __/ __| '_ \  / __| '_ \
#| (_| | | | | | |  __/ | | | |_| | |_) | (_| | || (__| | | |_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_| .__/ \__,_|\__\___|_| |_(_)___/_| |_|
#                                 |_|                Created by Prutserdt
#
# This script gives yes/no option to patch dmenu.
#
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory and restore the stable dmenu verstion.
# 2: write the diff filename to the diff_log 
# 3: Run the patch
#
# This shell script can be called by the .bashrc alias dmenupatch.
echo -n "Are you sure you want to patch the current dwm system? This will first: 
RESTORE TO THE STABLE VERSION OF DMENU and after that make clean install on the .diff file in the direcotory ~/Stack/suckless/dmenu/patches/test. Yes or no? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/dmenu &&
    mkdir ~/suckless/dmenu &&
    cp -r ~/Stack/suckless/dmenu/dmenu-4.9_stable/* ~/suckless/dmenu &&
    cd ~/suckless/dmenu &&
    clear && ls -al
    dmenustable && 
    ls ~/Stack/suckless/dmenu/patches/test/*.diff >> ~/suckless/dmenu/log/diff_log &&
    cp -r ~/suckless/dmenu/config.h ~/suckless/dmenu/config.def.h &&
    rm ~/suckless/dmenu/config.h &&
    patch -p1 < ~/Stack/suckless/dmenu/patches/test/*.diff &&
    make clean install
else
    echo No
fi
