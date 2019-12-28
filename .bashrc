# ~/.bashrc
#   _               _              
#  | |__   __ _ ___| |__  _ __ ___ 
#  | '_ \ / _` / __| '_ \| '__/ __|
# _| |_) | (_| \__ \ | | | | | (__ 
#(_)_.__/ \__,_|___/_| |_|_|  \___|
#
# Modified by Prutserdt

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Display arch logo (asci art) and additional info in terminal
screenfetch

# Dotfile repository settings
# config: simplifying communication with GIT
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# dotfiles: search changed file(s) and add, commit and push to the bare GIT repo
alias dotfiles='config add -u :/ -v; config commit -m "Updated";config push -v'

# Change keyboard mapping
# The dotfile .kbswitch changes Esc/Caps and the Super_R to mod3
# (Esc/Caps for vim, and Super_R as an extra shortcut button in i3)
alias kbswitch='xmodmap ~/.bswitch'
