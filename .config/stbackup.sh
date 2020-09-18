#!/bin/bash
# ~/.config/stbackup.sh
#     _   _                _                     _
# ___| |_| |__   __ _  ___| | ___   _ _ __   ___| |__
#/ __| __| '_ \ / _` |/ __| |/ / | | | '_ \ / __| '_ \
#\__ \ |_| |_) | (_| | (__|   <| |_| | |_) |\__ \ | | |
#|___/\__|_.__/ \__,_|\___|_|\_\\__,_| .__(_)___/_| |_|
#                                    |_|Created by Prutserdt
#
# This script gives yes/no option to mak a local backup of st.
# This shell script can be called by the .bashrc alias stbackup.
echo -n "Are you sure you want to make a backup of the current st verstion? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/Stack/suckless/st/st-0.8.4_stable && 
    mkdir ~/Stack/suckless/st/st-0.8.4_stable && 
    cp -r ~/suckless/st/* ~/Stack/suckless/st/st-0.8.4_stable
else
    echo No
fi
