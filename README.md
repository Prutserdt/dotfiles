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

### Remove an existing dotfile from this repo
```
config rm .example
config commit -m "Add my .example"
config push -v
```
### Pull from the GitHub repo
If one or more of the dotfiles were modified on another computer and committed
and pushed to the repo than this file can be added by:

    config pull

If there are new versions, then they will be updated.

### How to setup a new dotfiles repo
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
### How to add the dotfiles of this repo to a new Linux pc.

Make sure that git is installed and add a name and email:

    git config --global user.email "firstname@lastname.nl"
    git config --global user.name "Prutserdt"

Add the following alias to .bashrc:

    alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
    echo "dotfiles" >> .gitignore

Now clone your dotfiles into a bare repository in a "dotfiles" folder of your $HOME:

    git clone --bare https://github.com/Prutserdt/dotfiles.git $HOME/dotfiles

Define the alias in the current shell scope:

    alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

Checkout the actual content from the bare repository to your $HOME:

    config checkout

Probably there is an error message that some files are already excisting.
It's a good idea to make backup of the dotfiles in the ~/.config-backup directory:
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
Re-run the check out if you had problems:

    config checkout

Probably not everything is in the correct subdirectory, therefore add the following dirs:
```
mkdir .config-backup/.config
mkdir .config-backup/.config/i3
mkdir .config-backup/.config/i3status
mkdir .config-backup/.config/ranger
mkdir .config-backup/.config/vifm
mkdir .config-backup/.config/i3status
mkdir .config-backup/Stack
mkdir .config-backup/Stack/Command_line
```
And then perform the same previously performed commands:

    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} mv {} .config-backup/{}

Now re-run the check and find out if there are still issues:

    config checkout

Set the flag showUntrackedFiles to no on this specific (local) repository:

    config config --local status.showUntrackedFiles no

If needed use:

    config checkout -f

### How to automatically login to GitHub
?? work in progress https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

## References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
- :book: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

### To do list
Hieronder is een lijst van dingen die nog aangepast/verbeterd moeten worden.

### Automatisch eerst een pull doen en daarna het uitvoeren van 'dotfiles'
Ik wil een enkele commando gebruiken om de nieuwste dotfiles te downloaden en
die daarna een commit/push doet als de locale pc nieuwere dotifles heeft.
Dus een combinatie van;

    config pull
    dotfiles

Wat ik ook kan doen is alles anders doen.
dotfiles: --> run config status
plus geef als output wat te doen voor pull en push:

