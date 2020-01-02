#!/bin/bash
# ~/.config/dotfiles.sh
#     _       _    __ _ _                 _     
#  __| | ___ | |_ / _(_) | ___  ___   ___| |__  
# / _` |/ _ \| __| |_| | |/ _ \/ __| / __| '_ \ 
#| (_| | (_) | |_|  _| | |  __/\__ \_\__ \ | | |
# \__,_|\___/ \__|_| |_|_|\___||___(_)___/_| |_|
#                                               
# Created by Prutserdt
#
# This script checks the status of the dotfiles on this 
# computer compared to the GitHub repo. 
# After that it gives the options to perform a push or 
# a pull.

function Push()
{
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME add -u :/ -v; 
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME commit -m "Updated";
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME push -v 
}

function Pull()
{
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME pull
}

clear &&
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME status &&
read -p "
-------------------------------------------------------------------------------------------

Please carefully check the output that is printed above.....

If the branch is not up to date: PULL.

If the 'Changes not staged for commit' shows greyed out area: PUSH.

Are you sure you want to exchange (PULL or PUSH) with the dotfiles bare GitHub repo? [y/N]> " answer
case ${answer:0:1} in
    y|Y )
        read -p "
-------------------------------------------------------------------------------------------

OK, let's continue then!

Do you want to make a push to the GitHub repo? [y/N]> " answer2
        case ${answer2:0:1} in
            y|Y )
            Push
            ;;
            * )
            read -p "
-------------------------------------------------------------------------------------------

OK, clear. You apparently do not want to push to the Github repo.

Do you want to make a pull to the GitHub repo perhaps? (y/N)> " answer3
            case ${answer3:0:1} in
                y|Y )
                Pull
                    ;;
                * )
                 echo -------------------------------------------------------------------------------------------
                 echo
                 echo Alrightly then. If you say so. Exiting!
                 echo
                 ;;
            esac    
            ;;
        esac
    ;;
    * )
        echo -------------------------------------------------------------------------------------------
        echo 
        echo Hellz no! Thanks for getting me outta here!
        echo
    ;;
esac
