#!/bin/sh
#~/.config/dmenuinternet.sh
#     _                            _       _                       _         _
#  __| |_ __ ___   ___ _ __  _   _(_)_ __ | |_ ___ _ __ _ __   ___| |_   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | | | '_ \| __/ _ \ '__| '_ \ / _ \ __| / __| '_ \
#| (_| | | | | | |  __/ | | | |_| | | | | | ||  __/ |  | | | |  __/ |_ _\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|_|_| |_|\__\___|_|  |_| |_|\___|\__(_)___/_| |_|
#                                                              Created by Prutserdt
#
# Script to select webpages (~/.config/urls) in Firefox by dmenu.
# It opens: ~/.config/urls
# This requires the dmenu patch: center, which gives the dmenu -c option.
#cat ~/.config/urls | dmenu -i -c -l 30 | awk '{print $1}'| xclip -selection clipboard && firefox "$(xclip -o -selection clipboard)"
chosen=$(cat ~/.config/urls | dmenu -i -c -l 30)

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically open
firefox $chosen
