# 
# ~/.bashrc
# Modified by Prutserdt

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Display arch logo (asci art) and additional info in terminal
screenfetch

# dotfile repository settings
# config: simplifying communication with GIT
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# dotfiles: search changed file(s) and add, commit and push to the bare GIT repo
alias dotfiles='config add -u :/ -v; config commit -m "Updated";config push -v'
