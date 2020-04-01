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

PS1='[\u@\h \W]\$ '

# Display arch logo (asci art) and additional info in terminal
screenfetch

##############
# Alias list #
##############
# Colored output ls command
alias ls='ls --color=auto'
# Lazy man's ls
alias l='ls -l'
# Exiting quickly
alias q="exit"
# Clear screen quickly
alias c="clear"
# Clear screen and show content
alias cls="clear;ls"
# Fuzzy find history
alias h="history | fzf"
# History executable. https://superuser.com/questions/7414/how-can-i-search-the-bash-history-and-rerun-a-command
alias hx='eval $(history | sed "s/^ *[0-9]* *//g" | fzf --tac --tiebreak=index)'
# Fuzzy find in the most recent i3_log file 
alias fzlog='fzf < ~/i3_log/"$(ls -Art ~/i3_log | tail -n1)"'

# Dotfiles repository.
# Starts with a status check and after that gives some options to push/pull.
alias dotfiles='~/.config/dotfiles.sh'
# OLD
# config: simplifying communication with GIT
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# alias dotfiles='config add -u :/ -v; config commit -m "Updated";config push -v'

# Change keyboard mapping
# The dotfile .kbswitch changes Esc/Caps and the Super_R to mod3
# (Esc/Caps for vim, and Super_R as an extra shortcut button in i3)
alias kbswitch='xmodmap ~/.config/kbswitch'
# Lazy man's kbswitch command (I will switch to this permanently when used to it
alias k='xmodmap ~/.config/kbswitch'
