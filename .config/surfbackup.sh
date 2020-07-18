#!/bin/bash
# ~/.config/surfbackup.sh
#                 __ _                _                     _
# ___ _   _ _ __ / _| |__   __ _  ___| | ___   _ _ __   ___| |__
#/ __| | | | '__| |_| '_ \ / _` |/ __| |/ / | | | '_ \ / __| '_ \
#\__ \ |_| | |  |  _| |_) | (_| | (__|   <| |_| | |_) |\__ \ | | |
#|___/\__,_|_|  |_| |_.__/ \__,_|\___|_|\_\\__,_| .__(_)___/_| |_|
#                                               |_| Created by Prutserdt
#
# This script gives yes/no option to make a local backup of surf.
# This shell script can be called by the .bashrc alias surfbackup.
echo -n "Are you sure you want to make a backup of the current surf version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/Stack/suckless/surf/surf-2.0_stable &&
    mkdir ~/Stack/suckless/surf/surf-2.0_stable &&
    cp -r ~/suckless/surf/* ~/Stack/suckless/surf/surf-2.0_stable
else
    echo No
fi
