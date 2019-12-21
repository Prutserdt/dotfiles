# 
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# geeft arch logo in asci art plus wat extra info
screenfetch

# Voor de bare repository voor dotfiles (zie commandline doc)
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# Voor eenvoudig updaten van dotfiles
alias dotfiles='config add -u :/ -v; config commit -m "Updated";config push -v'
