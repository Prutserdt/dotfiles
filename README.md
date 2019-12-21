<!Dit is de ~/README.md file voor mijn dotfile Github/>
# Dotfile repo!
Here I store my dotfiles and other text files.
### Current list of files:
* .Xdefaults
* .Xmodmap
* .Xresources
* .bashrc
* .vimrc
* .xinitrc
* README.md
* .config/i3/config
* Stack/Command_line/commands.md
### Commit and push to the repo
If one or more of these files from the list  are changed locally, then the bare GitHub repository can be updated by:
```
config add -u :/ -v
config commit -m "Updated"
config push -v
```
### Add a file to this repo
```
config add .voorbeeld
config commit -m "Add my .voorbeeld"
config push -v
```
** Remember to update the current list of files in the README.md file!** :wink:

### Short manual how to setup a dotfile repo
First create a Dotfiles directory at home then;
```
git remote add dotfiles https://github.com/Prutserdt/dotfiles.git
git push dotfiles
git push --set-upstream dotfiles master
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no
```

References:
- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.youtube.com/watch?v=tBoLDpTWVOM.
