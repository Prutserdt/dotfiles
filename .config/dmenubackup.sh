#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tange (emacs)
	echo -n "Are you sure you want to make a backup of the current dmenu version? (y/n) "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
	    rm -r ~/Stack/Dotfiles/dmenu/dmenu-4.9_stable &&
	    mkdir ~/Stack/Dotfiles/dmenu/dmenu-4.9_stable &&
	    cp -r ~/.config/suckless/dmenu/* ~/Stack/Dotfiles/dmenu/dmenu-4.9_stable
	else
	    echo No
	fi
