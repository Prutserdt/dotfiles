<!Dit is de ~/README.md file voor mijn dotfile bare Github repo/>
# Dotfiles repo! 
Here I store my dotfiles and other text files of my Arch Linux i3wm system. :godmode:

The files of this repo can be found in the list above this readme file.

The applications needed to run my i3 config can be found in
*./config/applications.md*.

## The dotfiles command and how to manage this bare GitHub repo
### Commit and push to the repo: `dotfiles`
If one or more of the files of this repo are changed on a local machine, then this bare GitHub repository can be updated by a single command:
```
dotfiles
````
This `dotfiles` command is set on the local machine as an alias in .bashrc and consists of the following line:
```
alias dotfiles='config add -u :/ -v; config commit -m "Updated";config push -v'
```
The `config` alias is also set in the .bashrc as:
```
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```
### Add an additional dotfile to this repo
```
config add .example
config commit -m "Add my .example"
config push -v
```

### Remove an existing dotfile from the repo
```
config rm .example
config commit -m "Add my .example"
config push -v
```
### Short manual how to setup a dotfiles repo
First create a `dotfiles` directory at ~/ then enter from ~/:
```
git remote add dotfiles https://github.com/Prutserdt/dotfiles.git
git push dotfiles
git push --set-upstream dotfiles master
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no
```
### Short manual how to automatically login to GitHub
?? work in progress https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

### References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
- :book: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once
