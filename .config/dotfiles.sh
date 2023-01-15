# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
#!/bin/bash
# ~/.config/dotfiles.sh

notify-send "Dotfiles synchronization"
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
clear &&
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME status &&
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
                notify-send "Push performed on the Github dotfiles repository"
                ;;
            [2])
                echo --------------------------------------------------
                echo
                Pull
                notify-send "Pull performed on the Github dotfiles repository"
                ;;
            [3])
                echo --------------------------------------------------
                echo
                Pull
                Push
                notify-send "Pull and Push performed on the Github dotfiles repository"
                ;;
            [4])
                echo --------------------------------------------------
                echo
                echo As you whish: exiting
                notify-send "Exited the dotfiles synchronization with Github"
                ;;

            *)  echo --------------------------------------------------
                echo
                echo "Invalid input, exiting"
                notify-send "Invalid input added during the dotfiles synchronization with Github"
            ;;
esac
