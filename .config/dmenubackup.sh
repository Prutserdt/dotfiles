#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
	echo -n "Are you sure you want to make a backup of the current dmenu version? (y/n) "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
	    rm -r ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable &&
	    mkdir ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable &&
	    cp -r ~/.config/suckless/dmenu/* ~/Stack/Dotfiles/dmenu/dmenu-distrotube_stable
	else
	    echo No
	fi
