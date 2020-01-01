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
### How to setup a dotfiles repo
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

test

#### Voeg mijn dotfiles bestanden van GitHub toe aan een nieuwe computer

Zorg dat git geinstalleerd is en voeg naam en email toe:

    git config --global user.email "firstname@lastname.nl"
    git config --global user.name "Prutserdt"

De omschrijving staat hier: `https://www.atlassian.com/git/tutorials/dotfiles`

Voeg toe aan .bashrc (als het er nog niet staat):
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
echo "dotfiles" >> .gitignore

Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:
git clone --bare https://github.com/Prutserdt/dotfiles.git $HOME/dotfiles

(nu voer je de naam en wachtwoord in voor GitHub)

Define the alias in the current shell scope:
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

Checkout the actual content from the bare repository to your $HOME:
config checkout

Daarna komt er een foutmelding dat deze files al bestaan.
Voeg in de terminal de volgende toe om de files op te slaan
in de ~/.config-backup directory:

mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

Re-run the check out if you had problems:
config checkout

Ik had nog steeds enkele bestanden die niet weggeschreven zijn, deze
heb ik handmatig verplaatst door bijv. dit te doen:
mkdir .config-backup/.config
mkdir .config-backup/.config/i3
mkdir .config-backup/.config/i3status
mkdir .config-backup/.config/ranger
mkdir .config-backup/.config/vifm
mkdir .config-backup/.config/i3status
mkdir .config-backup/Stack
mkdir .config-backup/Stack/Command_line

config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

Re-run the check out if you had problems:
config checkout

Set the flag showUntrackedFiles to no on this specific (local) repository:
config config --local status.showUntrackedFiles no

Het lukt om te pullen!
Ga ik ~/dotfiles staan (weet niet zeker of dit nodig is) en voer in:
config pull
daarna worden nieuwe versies gepulled!


### How to automatically login to GitHub
?? work in progress https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

### References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
- :book: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once
