#!/bin/bash
# ~/.config/surfpatch.sh
#                 __             _       _           _
# ___ _   _ _ __ / _|_ __   __ _| |_ ___| |__    ___| |__
#/ __| | | | '__| |_| '_ \ / _` | __/ __| '_ \  / __| '_ \
#\__ \ |_| | |  |  _| |_) | (_| | || (__| | | |_\__ \ | | |
#|___/\__,_|_|  |_| | .__/ \__,_|\__\___|_| |_(_)___/_| |_|
#                   |_|                Created by Prutserdt
#
# This script gives yes/no option to make a patch on surf.
#
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory and restore the stable surf verstion.
# 2: write the diff filename to the diff_log 
# 3: Run the patch
#
# This shell script can be called by the .bashrc alias surfpatch.
echo -n "Are you sure you want to patch the current surf system? This will first: 
RESTORE TO THE STABLE SURF VERSION and after that make clean install on the .diff file in the direcotory ~/Stack/suckless/surf/patches/test. Yes or no? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/Stack/suckless/surf/surf-2.0_stable &&
    mkdir ~/Stack/suckless/surf/surf-2.0_stable &&
    cp -r ~/suckless/surf/* ~/Stack/suckless/surf/surf-2.0_stable
else
    echo No
fi
