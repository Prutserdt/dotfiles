#!/bin/bash
# ~/.config/dmenubackup.sh
#     _                            _                _                           _
#  __| |_ __ ___   ___ _ __  _   _| |__   __ _  ___| | ___   _ _ __  ___   ___ | |__
# / _` | '_ ` _ \ / _ \ '_ \| | | | '_ \ / _` |/ __| |/ / | | | '_ \/ __| / __|| '_ \
#| (_| | | | | | |  __/ | | | |_| | |_) | (_| | (__|   <| |_| | |_) \__ \_\__ \| | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|_.__/ \__,_|\___|_|\_\\__,_| .__/|___(_)___/|_| |_|
#                                                             |_| Created by Prutserdt
#
# This script gives yes/no option to mak a local backup of dmenu.
# This shell script can be called by the .bashrc alias dmenubackup.
echo -n "Are you sure you want to make a backup of the current dmenu version? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/Stack/suckless/dmenu/dmenu-4.9_stable &&
    mkdir ~/Stack/suckless/dmenu/dmenu-4.9_stable &&
    cp -r ~/.config/suckless/dmenu/* ~/Stack/suckless/dmenu/dmenu-4.9_stable
else
    echo No
fi
