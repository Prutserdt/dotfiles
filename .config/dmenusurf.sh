#!/bin/sh

# Script to select webpages (~/.config/urls) in Firefox by dmenu.
# It opens: ~/.config/urls
# This required the dmenu patch: center, which gives the dmenu -c option.
cat ~/.config/urls | dmenu -i -c -l 30 | awk '{print $1}'| xclip -selection clipboard && surf "$(xclip -o -selection clipboard)"
