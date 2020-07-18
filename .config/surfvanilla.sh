#!/bin/bash
# ~/.config/surfvanilla.sh
#                 __                  _ _ _             _
# ___ _   _ _ __ / _|_   ____ _ _ __ (_) | | __ _   ___| |__
#/ __| | | | '__| |_\ \ / / _` | '_ \| | | |/ _` | / __| '_ \
#\__ \ |_| | |  |  _|\ V / (_| | | | | | | | (_| |_\__ \ | | |
#|___/\__,_|_|  |_|   \_/ \__,_|_| |_|_|_|_|\__,_(_)___/_| |_|
#                                         Created by Prutserdt
#
# This script gives yes/no option to restore to vanilla surf.
# This script can be called by the .bashrc alias surfvanilla.
echo -n "Are you sure you want to restore to vanilla surf and DELETE the current surf system? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/surf &&
    mkdir ~/suckless/surf &&
    cp -r ~/Stack/suckless/surf/surf-2.0_vanilla/* ~/suckless/surf &&
    cd ~/suckless/surf &&
    clear && ls -al
else
    echo No
fi
