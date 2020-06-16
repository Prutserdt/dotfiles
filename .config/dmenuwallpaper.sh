#!/bin/sh
#~/.config/dmenuwallpaper.sh
#     _                                          _ _                                 _               
#  __| |_ __ ___   ___ _ __  _   ___      ____ _| | |_ __   __ _ _ __   ___  _ __ ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \| '__/ __| '_ \
#| (_| | | | | | |  __/ | | | |_| |\ V  V / (_| | | | |_) | (_| | |_) |  __/| | _\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_| \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___||_|(_)___/_| |_|
#                                                   |_|         |_|
#                                                                       Created by Prutserdt
#
# Script to change the wallpaper by dmenu.
# This required the dmenu patch: center, which gives the dmenu -c option.
ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -c -l 30 | awk '{print $1}'| xclip -selection clipboard && feh --bg-center "$(xclip -o -selection clipboard)"
