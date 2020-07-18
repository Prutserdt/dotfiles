#!/bin/bash
# ~/.config/dwmvanilla.sh
#    _                                    _ _ _             _
# __| |_      ___ __ _____   ____ _ _ __ (_) | | __ _   ___| |__
#/ _` \ \ /\ / / '_ ` _ \ \ / / _` | '_ \| | | |/ _` | / __| '_ \
# (_| |\ V  V /| | | | | \ V / (_| | | | | | | | (_| |_\__ \ | | |
#\__,_| \_/\_/ |_| |_| |_|\_/ \__,_|_| |_|_|_|_|\__,_(_)___/_| |_|
#                                             Created by Prutserdt
#
# This script gives yes/no option to restore to vanilla dwmm.
# This script can be called by the .bashrc alias dwmbackup.
echo -n "Are you sure you want to restore to vanilla dwm and DELETE the current dwm system? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/dwm &&
    mkdir ~/suckless/dwm &&
    cp -r ~/Stack/suckless/dwm/dwm-6.2_20200512_vanilla/* ~/suckless/dwm &&
    cd ~/suckless/dwm &&
    clear && ls -al
else
    echo No
fi
