#!/bin/bash
# ~/.config/stpatch.sh
#     _               _       _           _
# ___| |_ _ __   __ _| |_ ___| |__    ___| |__
#/ __| __| '_ \ / _` | __/ __| '_ \  / __| '_ \
#\__ \ |_| |_) | (_| | || (__| | | |_\__ \ | | |
#|___/\__| .__/ \__,_|\__\___|_| |_(_)___/_| |_|
#        |_|                Created by Prutserdt
#
# This script gives yes/no option to make a patch of st.
#
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory and restore the stable st version.
# 2: write the diff filename to the diff_log 
# 3: Run the patch
#
# This shell script can be called by the .bashrc alias stpatch.
echo -n "Are you sure you want to patch the current st version? This will first: 
RESTORE TO THE STABLE ST VERSIONM and after that make clean install on the .diff file in the direcotory ~/Stack/suckless/st/patches/test. Yes or no? (y/n) "
read answer
# if echo "$answer" | grep -iq "^y" ;then
if [ "$answer" != "${answer#[Yy]}" ] ;then
    rm -r ~/suckless/st &&
    mkdir ~/suckless/st &&
    cp -r ~/Stack/suckless/st/st-0.8.4_stable/* ~/suckless/st &&
    cd ~/suckless/st &&
    clear && ls -al &&
    ls ~/Stack/suckless/st/patches/test/*.diff >> ~/suckless/st/log/diff_log &&
    cp -r ~/suckless/st/config.h ~/suckless/st/config.def.h &&
    rm ~/suckless/st/config.h && patch -p1 < ~/Stack/suckless/st/patches/test/*.diff &&
    make clean install
else
    echo No
fi
