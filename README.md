<!Dit is de ~/README.md file voor mijn dotfile Github/>
# Dotfile repo!# 
Here I store my dotfiles and other text files. :godmode:

The current list of files in this repo can be found in the list above this
readme file.

### Commit and push to the repo: `dotfiles`
If one or more of these files from the list  are changed locally, then the bare GitHub repository can be updated by a single command:
```
dotfiles
````
This command is set as alias in .bashrc and consists of the following lines:
```
config add -u :/ -v
config commit -m "Updated"
config push -v
```
### Add an additional file to this repo
```
config add .example
config commit -m "Add my .example"
config push -v
```
*Remember to update the current list of files in the README.md file!* :wink:

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

### References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
