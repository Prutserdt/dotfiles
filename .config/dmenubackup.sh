#!/bin/bash
	echo -n "Are you sure you want to make a backup of the current dmenu version? (y/n) "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
	    rm -r ~/Stack/Dotfiles/suckless/dmenu/dmenu-4.9_stable &&
	    mkdir ~/Stack/Dotfiles/suckless/dmenu/dmenu-4.9_stable &&
	    cp -r ~/.config/suckless/dmenu/* ~/Stack/Dotfiles/suckless/dmenu/dmenu-4.9_stable
	else
	    echo No
	fi
