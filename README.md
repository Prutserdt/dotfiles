<!Dit is de ~/README.md file voor mijn dotfile bare Github repo/>
# Dotfiles repo :exclamation: :metal:
Here I store my dotfiles and other text files of my Arch Linux i3wm system.

The applications needed to run my i3 config can be found in *./config/applications.md*.

## The `dotfiles` command
This alias from the .bashrc is running the shell script *~/.config/dotfiles.sh*.
This script will first check the status of the dotfiles and after that a commit/push 
or pull can be made to the repo. Yes, this is all done from one command! :godmode:.

Remember: if the local dotfiles are newer than the rep : push. If the local dotfiles 
are older than the repo: pull.

### Add an additional dotfile to this repo

    config add .example
    config commit -m "Add my .example"
    config push -v

### Remove an existing dotfile from this repo

    config rm .example
    config commit -m "Add my .example"
    config push -v

## References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
- :book: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

----
----
----
## To do list, nice ideas :bulb:, not there yet :smirk:, potentially :tada:
A list of potential improvements

### How to automatically login to GitHub
?? work in progress https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

### Saving personal Firefox links
Locatie: `/home/archie/.mozilla/firefox/1aa2cc3p.default-1466333760664`

### Automating the dotfiles command
The choice to push or pull could be automated...
