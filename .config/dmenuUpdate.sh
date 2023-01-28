#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
notify-send "Running dmenuUpdate.sh" &&
rm $HOME/'.cache/dmenu_run' &
ls /usr/bin/* > $HOME/.cache/dmenu_run &&
shopt -s nullglob # When AppImages aren't present then the loop will not be run
FILES=$HOME/Applications/*.AppImage
for f in $FILES
do
    sed -i '1 i '$f  $HOME/.cache/dmenu_run
done
notify-send -t 60000 "A new list of installed applications is made 😃"
