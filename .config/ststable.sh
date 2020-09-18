#!/bin/bash
# ~/.config/ststable.sh
#     _       _        _     _            _
# ___| |_ ___| |_ __ _| |__ | | ___   ___| |__
#/ __| __/ __| __/ _` | '_ \| |/ _ \ / __| '_ \
#\__ \ |_\__ \ || (_| | |_) | |  __/_\__ \ | | |
#|___/\__|___/\__\__,_|_.__/|_|\___(_)___/_| |_|
#                           Created by Prutserdt
#
# This script gives yes/no option to mak a local backup of st.
# This script can be called by the .bashrc alias ststable.
echo -n "Are you sure you want to restore to the stable version and DELETE
the current st version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/st &&
    mkdir ~/suckless/st &&
    cp -r ~/Stack/suckless/st/st-0.8.4_stable/* ~/suckless/st &&
    cd ~/suckless/st &&
    clear && ls -al
else
    echo No
fi
