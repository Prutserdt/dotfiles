<!Dit is de ~/README.md file voor mijn dotfile bare Github repo/>
# :sparkles:Dotfiles:sparkles: repo, including my suckless builds:bangbang:
Here I store the :sparkles:dotfiles:sparkles: of my GNU/Linux system plus some 
other stuff.

[This directory](https://github.com/Prutserdt/dotfiles/tree/master/suckless) 
contains my suckless builds, including my window manager (dwm) and my terminal (st). 

This is how my dwm desktop can look like:
![full rice](dwm.jpg)
This is how I use it:
![productivity](dwm2.jpg)

My old i3 gaps config file is still a part of this repo although I do not use it 
anymore.

## :eight_pointed_black_star:The `dotfiles` command
A silly alias from the *[.bashrc](https://github.com/Prutserdt/dotfiles/blob/master/.bashrc)*
is running the shell script 
*[./config/dotfiles.sh](https://github.com/Prutserdt/dotfiles/blob/master/.config/dotfiles.sh)*
. This checks the status of this bare github dotfiles repo and gives a menu to commit/push :godmode:

## :eight_pointed_black_star:Add a dotfile to this repo :inbox_tray:
(`config` is an alias from *[.bashrc](https://github.com/Prutserdt/dotfiles/blob/master/.bashrc)*)

    config add .example
    config commit -m "Add my .example"
    config push -v

## :eight_pointed_black_star:Remove a dotfile from this repo :outbox_tray:
(`config` is an alias from *[.bashrc](https://github.com/Prutserdt/dotfiles/blob/master/.bashrc)*)

    config rm .example
    config commit -m "Remove my .example"
    config push -v

## :eight_pointed_black_star:References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
