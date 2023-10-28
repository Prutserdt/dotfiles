# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
#!/bin/bash
# ~/.config/dotfiles.sh

notify-send -t 60000 "Running dotfiles.sh" &&
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
read choice

case "$choice" in
  1)
    echo "Are you sure you want to push to Github? (y/n)"
    read confirm
    if [ "$confirm" = "y" ]; then
      Push
    else
      echo "Push operation canceled."
    fi
    ;;
  2)
    echo "Are you sure you want to pull from Github? This will overwrite all of your local files. (y/n)"
    read confirm
    if [ "$confirm" = "y" ]; then
      Pull
    else
      echo "Pull operation canceled."
    fi
    ;;
  3)
    echo "Are you sure you want to pull and commit/push? (y/n)"
    read confirm
    if [ "$confirm" = "y" ]; then
      Pull
      Push
    else
      echo "Pull and commit/push operation canceled."
    fi
    ;;
  4)
    exit
    ;;
  *)
    echo "Invalid option. Please select a valid option (1-4)."
    ;;
esac
