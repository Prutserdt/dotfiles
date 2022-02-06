#!/bin/bash
# ~/.config/dwmpatch.sh
#     _                                _       _           _
#  __| |_      ___ __ ___  _ __   __ _| |_ ___| |__    ___| |__
# / _` \ \ /\ / / '_ ` _ \| '_ \ / _` | __/ __| '_ \  / __| '_ \
#| (_| |\ V  V /| | | | | | |_) | (_| | || (__| | | |_\__ \ | | |
# \__,_| \_/\_/ |_| |_| |_| .__/ \__,_|\__\___|_| |_(_)___/_| |_|
#                         |_|                Created by Prutserdt
#
# This script gives yes/no option to mak a local backup of dwmm.
#
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory and restore the stable dwm verstion.
# 2: write the diff filename to the diff_log 
# 3: Run the patch
#
# This shell script can be called by the .bashrc alias dwmbackup.
echo -n "Are you sure you want to patch the current dwm system? This will
first: RESTORE TO THE STABLE DWM and after that make clean install on the .diff
file in the direcotory ~/Stack/Dotfiles/suckless/dwm/patches/test. Yes or no? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/.config/suckless/dwm &&
    mkdir ~/.config/suckless/dwm &&
    mkdir ~/.config/suckless/dwm/log &&
    cp -r ~/Stack/Dotfiles/suckless/dwm/dwm-6.2_stable/* ~/.config/suckless/dwm && 
    cd ~/.config/suckless/dwm &&
    clear && ls -al &&
    ls ~/Stack/Dotfiles/suckless/dwm/patches/test/*.diff >> ~/.config/suckless/dwm/log/diff_log && 
    cp -r ~/.config/suckless/dwm/config.h ~/.config/suckless/dwm/config.def.h && 
    rm ~/.config/suckless/dwm/config.h && 
    patch -p1 < ~/Stack/Dotfiles/suckless/dwm/patches/test/*.diff &&
    make clean install
#    rm -r ~/suckless/dwm &&
#    mkdir ~/suckless/dwm &&
#    mkdir ~/suckless/dwm/log &&
#    cp -r ~/Stack/suckless/dwm/dwm-6.2_stable/* ~/suckless/dwm && 
#    cd ~/suckless/dwm &&
#    clear && ls -al &&
#    ls ~/Stack/suckless/dwm/patches/test/*.diff >> ~/suckless/dwm/log/diff_log && 
#    cp -r ~/suckless/dwm/config.h ~/suckless/dwm/config.def.h && 
#    rm ~/suckless/dwm/config.h && 
#    patch -p1 < ~/Stack/suckless/dwm/patches/test/*.diff &&
#    make clean install
else
    echo No
fi
