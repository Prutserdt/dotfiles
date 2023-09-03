#!/bin/sh
# ~/.bashrc
#   _               _              
#  | |__   __ _ ___| |__  _ __ ___ 
#  | '_ \ / _` / __| '_ \| '__/ __|
# _| |_) | (_| \__ \ | | | | | (__ 
#(_)_.__/ \__,_|___/_| |_|_|  \___|
#             Modified by Prutserdt

#
# Switched to zsh. Check the .zshrc for my current config
#

[[ $- != *i* ]] && return           # If not running interactively, don't do anything
PS1='[\u@\h \W]\$ '
PROMPT_COMMAND='printf "\033]0;[%s@%s]$ %s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/"~"}"' # Make windowname: [user@host]$ directory 
pfetch                              # Display arch logo (asci art) and additional info in terminal
#cowthink $(fortune)                 # Let the cow quote! (requires conwsay and fortune-mod)
HISTSIZE=5000                       # Make size of bash history 5000 (500= default) 
HISTFILESIZE=10000                  # and the total amount of maximally saved lines
HISTCONTROL=ignoredups:erasedups    # Do not add duplicate entries and no spaces
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"


# Alias definitions. Sourced in bash and zsh.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

export NNN_BMS='h:~;r=~/qmk_firmware/keyboards/redox/keymaps/Prutserdt'
PATH="$HOME/.local/bin:$PATH"
