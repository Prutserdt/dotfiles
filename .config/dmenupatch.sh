#!/bin/sh
	echo -n "Are you sure you want to patch the current dwm system? This will first:
	RESTORE TO THE STABLE VERSION OF DMENU and after that make clean install on the .diff file in the direcotory ~/Stack/Dotfiles/suckless/dmenu/patches/test. Yes or no? (y/n) "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
	    rm -r ~/.config/suckless/dmenu &&
	    mkdir ~/.config/suckless/dmenu &&
	    cp -r ~/Stack/Dotfiles/suckless/dmenu/dmenu-4.9_stable/* ~/.config/suckless/dmenu &&
	    cd ~/.config/suckless/dmenu &&
	    clear && ls -al
	    ls ~/Stack/Dotfiles/suckless/dmenu/patches/test/*.diff >> ~/.config/suckless/dmenu/log/diff_log &&
	    cp -r ~/.config/suckless/dmenu/config.h ~/.config/suckless/dmenu/config.def.h &&
	    rm ~/.config/suckless/dmenu/config.h &&
	    patch -p1 < ~/Stack/Dotfiles/suckless/dmenu/patches/test/*.diff &&
	    make clean install
	else
	    echo No
	fi
