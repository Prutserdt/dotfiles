#!/bin/sh
	#~/.config/dmenuthunar.sh
	#     _                            _   _                                _
	#  __| |_ __ ___   ___ _ __  _   _| |_| |__  _   _ _ __   __ _ _ __ ___| |__
	# / _` | '_ ` _ \ / _ \ '_ \| | | | __| '_ \| | | | '_ \ / _` | '__/ __| '_ \
	#| (_| | | | | | |  __/ | | | |_| | |_| | | | |_| | | | | (_| | | _\__ \ | | |
	# \__,_|_| |_| |_|\___|_| |_|\__,_|\__|_| |_|\__,_|_| |_|\__,_|_|(_)___/_| |_|
	#                                                         Created by Prutserdt
	#
	# Script to select directories (~/.config/directories) in Thunar by dmenu.
	# This requires the dmenu patch: center, which gives the dmenu -c option.
	chosen=$(cat ~/.config/directories | dmenu -i -c -l 30)

	# Exit if none chosen.
	[ -z "$chosen" ] && exit
	thunar $chosen
