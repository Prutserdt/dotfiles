#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
# Set the paths to the directories file and the bookmarks file
DIR_FILE=~/Stack/Command_line/directories
BOOKMARKS_FILE=~/.config/gtk-3.0/bookmarks

# Loop through each directory in the directories file
#while read -r; do
while read -r dir; do
    # Convert the directory path to a bookmark path and append it to the bookmarks file
    echo "file://$dir" >> $BOOKMARKS_FILE
done < $DIR_FILE
