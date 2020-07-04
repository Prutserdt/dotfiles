#!/bin/bash
# ~/.config/exitdwm.sh
#           _ _      _                          _
#  _____  _(_) |_ __| |_      ___ __ ___    ___| |__
# / _ \ \/ / | __/ _` \ \ /\ / / '_ ` _ \  / __| '_ \
#|  __/>  <| | || (_| |\ V  V /| | | | | |_\__ \ | | |
# \___/_/\_\_|\__\__,_| \_/\_/ |_| |_| |_(_)___/_| |_|
#                                 Created by Prutserdt
#
# This script gives yes/no option before exiting dwm.
# It is called in config.h of dwm.
echo -n "Do you wish to exit DWM violently now and kill everything? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
   killall dwm 
else
    echo No
fi
