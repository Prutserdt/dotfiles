#!/bin/bash
# ~/.config/dwmstable.sh
#     _                        _        _     _            _
#  __| |_      ___ __ ___  ___| |_ __ _| |__ | | ___   ___| |__
# / _` \ \ /\ / / '_ ` _ \/ __| __/ _` | '_ \| |/ _ \ / __| '_ \
#| (_| |\ V  V /| | | | | \__ \ || (_| | |_) | |  __/_\__ \ | | |
# \__,_| \_/\_/ |_| |_| |_|___/\__\__,_|_.__/|_|\___(_)___/_| |_|
#                                            Created by Prutserdt
#
# This script gives yes/no option to mak a local backup of dwmm.
# This script can be called by the .bashrc alias dwmbackup.
echo -n "Are you sure you want to restore to the stable version and DELETE
the current dwm version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/.config/suckless/dwm &&
    mkdir ~/.config/suckless/dwm &&
    mkdir ~/.config/suckless/dwm/log &&
    cp -r ~/Stack/Dotfiles/suckless/dwm/dwm-6.2_stable/* ~/.config/suckless/dwm &&
    cd ~/.config/suckless/dwm && # does not change directory, also not after
    #entering 'sleep 5' in front of this. strange
    clear && ls -al
else
    echo No
fi
