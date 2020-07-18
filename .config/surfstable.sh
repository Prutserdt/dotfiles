#!/bin/bash
# ~/.config/surfstable.sh
#                 __     _        _     _            _
# ___ _   _ _ __ / _|___| |_ __ _| |__ | | ___   ___| |__
#/ __| | | | '__| |_/ __| __/ _` | '_ \| |/ _ \ / __| '_ \
#\__ \ |_| | |  |  _\__ \ || (_| | |_) | |  __/_\__ \ | | |
#|___/\__,_|_|  |_| |___/\__\__,_|_.__/|_|\___(_)___/_| |_|
#                                      Created by Prutserdt
#
# This script gives yes/no option to restore the stable verion of surf.
# This script can be called by the .bashrc alias surfstable.
echo -n "Are you sure you want to restore to the stable version and DELETE the current surf version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/surf &&
    mkdir ~/suckless/surf &&
    cp -r ~/Stack/suckless/surf/surf-2.0_stable/* ~/suckless/surf &&
    cd ~/suckless/surf &&
    clear && ls -al
else
    echo No
fi
