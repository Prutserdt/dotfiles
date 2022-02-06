<!This is the ~/README.md file for ~/.config on  my bare Github repo/>

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

~ remember: change the ~/dotfiles/config to ssh:
	url = ssh://git@github.com/Prutserdt/dotfiles.git

## :eight_pointed_black_star:References:
- :book: https://www.atlassian.com/git/tutorials/dotfiles
- :cinema: https://www.youtube.com/watch?v=tBoLDpTWVOM
