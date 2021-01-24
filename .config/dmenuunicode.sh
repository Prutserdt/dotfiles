#!/bin/sh
#~/.config/dmenuunicode.sh
#     _                                        _               _            _
#  __| |_ __ ___   ___ _ __  _   _ _   _ _ __ (_) ___ ___   __| | ___   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | | | | | '_ \| |/ __/ _ \ / _` |/ _ \ / __| '_ \
#| (_| | | | | | |  __/ | | | |_| | |_| | | | | | (_| (_) | (_| |  __/_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|\__,_|_| |_|_|\___\___/ \__,_|\___(_)___/_| |_|
#                                                             Created by Prutserdt
#
# Simple script to paste emojis via dmenu.
# Requirement: dmenu and the center patch that gives the dmenu -c option.
#cat ~/.config/unicode | dmenu -i -l 45 -fn hack-34| awk '{print $1}'| xclip -selection clipboard &&
#cat ~/.config/unicode | dmenu -i -l 45| awk '{print $1}'| xclip -selection clipboard &&
cat ~/.config/unicode | dmenu -i -c -l 45| awk '{print $1}'| xclip -selection clipboard &&
#cat ~/.config/unicode | dmenu -i -l 45 -fn monospace-20| awk '{print $1}'| xclip -selection clipboard &&
#cat ~/.config/unicode | dmenu -i -l 45 -fn hack-34| awk '{print $1}'| xclip -selection clipboard &&
# Backspace is needed to remove the nextline
xdotool key "ctrl+v" "BackSpace"
