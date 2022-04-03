#!/bin/bash
# ~/.config/dmenustable.sh
#     _                            _   _           _       _             _
#  __| |_ __ ___   ___ _ __  _   _| | | |_ __   __| | __ _| |_ ___   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | | | | | '_ \ / _` |/ _` | __/ _ \ / __| '_ \
#| (_| | | | | | |  __/ | | | |_| | |_| | |_) | (_| | (_| | ||  __/_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|\___/| .__/ \__,_|\__,_|\__\___(_)___/_| |_|
#                                       |_|                Created by Prutserdt
#
# Script to create a list of applications that is used for dmenu.
#
# Delete the dmenu_run file
rm $HOME/'.cache/dmenu_run' &
# Create a new list of apps
ls /usr/bin/* > $HOME/.cache/dmenu_run #&&
# Add the appimages to the list of apps
sed -i '1 i ~/Downloads/stack-2.8.2-20210809-x86_64.AppImage' ~/.cache/dmenu_run &&
sed -i '2 i ~/Downloads/OpenShot-v2.5.1-dev3-daily-7905-fbe02428-c31fac5e-x86_64.AppImage' ~/.cache/dmenu_run
