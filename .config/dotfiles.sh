# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
#!/bin/bash
# ~/.config/dotfiles.sh

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
