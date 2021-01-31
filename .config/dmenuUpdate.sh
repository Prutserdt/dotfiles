#!/bin/bash
# ~/.config/dmenustable.sh
#     _                            _   _           _       _             _
#  __| |_ __ ___   ___ _ __  _   _| | | |_ __   __| | __ _| |_ ___   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | | | | | '_ \ / _` |/ _` | __/ _ \ / __| '_ \
#| (_| | | | | | |  __/ | | | |_| | |_| | |_) | (_| | (_| | ||  __/_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|\___/| .__/ \__,_|\__,_|\__\___(_)___/_| |_|
#                                       |_|                Created by Prutserdt
#
# Script to recreate the list of applications used for dmenu.
#
# Delete the dmenu_run file
rm '/home/icefly/.cache/dmenu_run' &&
# Create a new list of apps
ls /usr/bin/* > /home/icefly/.cache/dmenu_run &&
# Add the appimage to the list of apps
sed -i '1 i /home/icefly/Downloads/stack-2.6.5-20200909-x86_64.AppImage' /home/icefly/.cache/dmenu_run
