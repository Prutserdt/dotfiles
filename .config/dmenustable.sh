#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tange (emacs)
	echo -n "Are you sure you want to restore to the stable version and DELETE
	the current dmenu version? (y/n) "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
	    rm -r ~/.config/suckless/dmenu &&
	    mkdir ~/.config/suckless/dmenu &&
	    cp -r ~/Stack/Dotfiles/dmenu/dmenu-4.9_stable/* ~/.config/suckless/dmenu &&
	    cd ~/.config/suckless/dmenu &&
	    clear && ls -al
	else
	    echo No
	fi
