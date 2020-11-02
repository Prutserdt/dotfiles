#!/bin/bash
# ~/.config/dmenustable.sh
#     _                                _        _     _            _
#  __| |_ __ ___   ___ _ __  _   _ ___| |_ __ _| |__ | | ___   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | / __| __/ _` | '_ \| |/ _ \ / __| '_ \
#| (_| | | | | | |  __/ | | | |_| \__ \ || (_| | |_) | |  __/_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|___/\__\__,_|_.__/|_|\___(_)___/_| |_|
#                                                    Created by Prutserdt
#
# This script gives yes/no option to make a local backup of dmenu.
# This script can be called by the .bashrc alias dmenustable.
echo -n "Are you sure you want to restore to the stable version and DELETE
the current dmenu version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/.config/suckless/dmenu &&
    mkdir ~/.config/suckless/dmenu &&
    cp -r ~/Stack/suckless/dmenu/dmenu-4.9_stable/* ~/.config/suckless/dmenu &&
    cd ~/.config/suckless/dmenu &&
    clear && ls -al
else
    echo No
fi
