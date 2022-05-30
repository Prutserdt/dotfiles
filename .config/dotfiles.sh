#!/bin/bash
# ~/.config/dotfiles.sh
#     _       _    __ _ _                 _     
#  __| | ___ | |_ / _(_) | ___  ___   ___| |__  
# / _` |/ _ \| __| |_| | |/ _ \/ __| / __| '_ \ 
#| (_| | (_) | |_|  _| | |  __/\__ \_\__ \ | | |
# \__,_|\___/ \__|_| |_|_|\___||___(_)___/_| |_|
#                           Created by Prutserdt
#
# This script checks the status of the dotfiles on this 
# computer compared to the bare GitHub repo and gives options. 
# 
# This shell can be called from the alias "dotfiles" .aliases


function Push()
{
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME add -u :/ -v; 
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME commit -m "Updated";
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME push -v 
}

function Pull()
{
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME reset --hard;
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME pull
}

# Clear screen and check the status of dotfiles
clear &&
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME status &&

# Give a menu (choose push/pull etc)
echo -n "--------------------------------------------------

Please read the status of the dotfiles carefully above.


Options:

1 commit/push 
2 pull (and first reset -hard)
3 pull and a commit/push
4 exit

[$USER@github.com/Prutserdt/dotfiles ~]:> "
read PullPush
case $PullPush in
            [1]) 
                echo --------------------------------------------------
                echo
                Push 
                ;;
            [2]) 
                echo --------------------------------------------------
                echo
                Pull
                ;;
            [3]) 
                echo --------------------------------------------------
                echo
                Pull
                Push
                ;;
            [4]) 
                echo --------------------------------------------------
                echo
                echo As you whish: exiting
                ;;

            *)  echo --------------------------------------------------
                echo
                echo "Invalid input, exiting"
            ;;
esac
