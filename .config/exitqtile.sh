#!/bin/bash
# ~/.config/exitqtile.sh
#           _ _        _   _ _            _
#  _____  _(_) |_ __ _| |_(_) | ___   ___| |__
# / _ \ \/ / | __/ _` | __| | |/ _ \ / __| '_ \
#|  __/>  <| | || (_| | |_| | |  __/_\__ \ | | |
# \___/_/\_\_|\__\__, |\__|_|_|\___(_)___/_| |_|
#                   |_|     Created by Prutserdt
#
#
# This script gives yes/no option before exiting dwm.
# It is set in config.h of dwm.
echo -n "Do you wish to exit qtile right now? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
   killall qtile 
else
    echo No
fi
