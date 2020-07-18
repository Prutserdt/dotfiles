#!/bin/bash
# ~/.config/stvanilla.sh
#     _                    _ _ _             _
# ___| |___   ____ _ _ __ (_) | | __ _   ___| |__
#/ __| __\ \ / / _` | '_ \| | | |/ _` | / __| '_ \
#\__ \ |_ \ V / (_| | | | | | | | (_| |_\__ \ | | |
#|___/\__| \_/ \__,_|_| |_|_|_|_|\__,_(_)___/_| |_|
#                              Created by Prutserdt
#
# This script gives yes/no option to restore to vanilla st.
# This script can be called by the .bashrc alias stvanillla.
echo -n "Are you sure you want to restore to vanilla st and DELETE the current st version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/st &&
    mkdir ~/suckless/st &&
    cp -r ~/Stack/suckless/st/st-0.8.3_vanilla/* ~/suckless/st &&
    cd ~/suckless/st &&
    clear && ls -al
else
    echo No
fi
