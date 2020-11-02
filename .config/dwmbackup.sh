#!/bin/bash
# ~/.config/dwmbackup.sh
#     _                    _                _                     _
#  __| |_      ___ __ ___ | |__   __ _  ___| | ___   _ _ __   ___| |__
# / _` \ \ /\ / / '_ ` _ \| '_ \ / _` |/ __| |/ / | | | '_ \ / __| '_ \
#| (_| |\ V  V /| | | | | | |_) | (_| | (__|   <| |_| | |_) |\__ \ | | |
# \__,_| \_/\_/ |_| |_| |_|_.__/ \__,_|\___|_|\_\\__,_| .__(_)___/_| |_|
#                                                     |_|
#                                                   Created by Prutserdt
#
# This script gives yes/no option to mak a local backup of dwmm.
# This shell script can be called by the .bashrc alias dwmbackup.
echo -n "Are you sure you want to make a backup of the current dwm system? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/Stack/suckless/dwm/dwm-6.2_stable/* &&
    cp -r ~/.config/suckless/dwm/* ~/Stack/suckless/dwm/dwm-6.2_stable
#    rm -r ~/Stack/suckless/dwm/dwm-6.2_stable/* &&
#    cp -r ~/suckless/dwm/* ~/Stack/suckless/dwm/dwm-6.2_stable
else
    echo No
fi
