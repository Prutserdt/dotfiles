<!Dit is de ~/README.md file voor mijn dotfile bare Github repo/>
# :sparkles:Dotfiles:sparkles: repo:bangbang::metal:
Here I store my  :sparkles:dotfiles:sparkles: and other text files of my Arch :penguin: i3wm :computer:.

The applications needed to run my i3 config can be found in *[./config/applications.md](https://github.com/Prutserdt/dotfiles/blob/master/.config/applications.md)*.
## :eight_pointed_black_star:The `dotfiles` command
This alias from the *[.bashrc](https://github.com/Prutserdt/dotfiles/blob/master/.bashrc)*
is running the shell script 
*[./config/dotfiles.sh](https://github.com/Prutserdt/dotfiles/blob/master/.config/dotfiles.sh)*
.This script will first check the status of the dotfiles and after that a commit/push 
or pull can be made to the repo. Yes, this is all done from one command! :godmode:

Remember: if the local dotfiles are newer than the repo: push. If the local dotfiles 
are older than the repo: pull.

### :eight_pointed_black_star:Add an additional dotfile to this repo :inbox_tray:

    config add .example
    config commit -m "Add my .example"
    config push -v

### :eight_pointed_black_star:Remove an existing dotfile from this repo :outbox_tray:

    config rm .example
    config commit -m "Remove my .example"
    config push -v

## :eight_pointed_black_star:References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
- :book: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

----
----
----
## :eight_pointed_black_star:To do list :smirk:, potentially :tada::boom::sunglasses:

### :fast_forward:Automatically login to GitHub
I cannot get this to work so far. I. MUST. BE. STUPID. :man_facepalming: :boom:
See: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

### :fast_forward:Saving personal Firefox links
Location: `/home/archie/.mozilla/firefox/1aa2cc3p.default-1466333760664`
Not sure if this is a good idea. Could be handy though :smiling_imp:

### :fast_forward:Automating the dotfiles command
The choice to push or pull could be automated...:shipit:
