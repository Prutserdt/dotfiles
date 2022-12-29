#!/bin/sh
	# ~/.config/dmenuUpdate.sh
	#     _                            _   _           _       _             _
	#  __| |_ __ ___   ___ _ __  _   _| | | |_ __   __| | __ _| |_ ___   ___| |__
	# / _` | '_ ` _ \ / _ \ '_ \| | | | | | | '_ \ / _` |/ _` | __/ _ \ / __| '_ \
	#| (_| | | | | | |  __/ | | | |_| | |_| | |_) | (_| | (_| | ||  __/_\__ \ | | |
	# \__,_|_| |_| |_|\___|_| |_|\__,_|\___/| .__/ \__,_|\__,_|\__\___(_)___/_| |_|
	#                                       |_|                Created by Prutserdt
	#
	# Script to create a list of applications that is used for dmenu.
	#
	# Delete the dmenu_run file
	rm $HOME/'.cache/dmenu_run' &

	# Create a new list of apps from my binaries
	ls /usr/bin/* > $HOME/.cache/dmenu_run &&

	# Add all of the appimages from $HOME/Applications to the dmenu_run file
	shopt -s nullglob # When AppImages aren't present then the loop will not be run
	FILES=$HOME/Applications/*.AppImage
	for f in $FILES
	do
	    #write to first line of the file (AppImages on top of list)
	    sed -i '1 i '$f  $HOME/.cache/dmenu_run
	done
