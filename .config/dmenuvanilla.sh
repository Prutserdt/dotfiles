#!/bin/bash
# ~/.config/dmenuvanilla.sh
#     _                                             _ _ _             _
#  __| |_ __ ___   ___ _ __  _   ___   ____ _ _ __ (_) | | __ _   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | \ \ / / _` | '_ \| | | |/ _` | / __| '_ \
#| (_| | | | | | |  __/ | | | |_| |\ V / (_| | | | | | | | (_| |_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_| \_/ \__,_|_| |_|_|_|_|\__,_(_)___/_| |_|
#                                                       Created by Prutserdt
#
# This script gives yes/no option to restore to vanilla dmenu.
# This script can be called by the .bashrc alias dmenuvanilla.
echo -n "Are you sure you want to restore to vanilla dmenu and DELETE the current dmenu version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/dmenu &&
    mkdir ~/suckless/dmenu &&
    cp -r ~/Stack/suckless/dmenu/dmenu-4.9_vanilla/* ~/suckless/dmenu &&
    cd ~/suckless/dmenu &&
    clear && ls -al
else
    echo No
fi
