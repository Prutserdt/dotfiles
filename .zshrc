# ~/.zshrc
#           _
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
# _ / /\__ \ | | | | | (__
#(_)___|___/_| |_|_|  \___|
#     modified by Prutserdt

###########################
#     Basic config        #
###########################
export PATH="$HOME/bin:$PATH" # ~/bin was addet to path, makes locale install of dwm possible via .xinitrc.

# TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!
# todo: do not add duplicates to history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

###########################
#         My theme        #
###########################
# Based on the xiong-chiamiov-plus.szh-theme, from oh-mh-zsh.
# user, host, full path, and time/date on two lines for easier vgrepping
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%a %b %d, %H:%M"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

pfetch                # Display arch logo (asci art) and additional info in terminal
cowthink $(fortune)   # Let the cow quote! (requires conwsay and fortune-mod)

###########################
#     oh-my-zsh stuff     #
###########################
# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

plugins=(
  thefuck
  autojump
  colored-man-pages
  z
  )

zstyle ':completion:*' file-sort name
zstyle :compinstall filename '/home/icefly/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select # arrow keys for selection autocomplete interface

setopt COMPLETE_ALIASES #autocomplete command line switches for aliases

zstyle ':completion::complete:*' gain-privileges 1 #autocomplete for sudo

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases    #use this aliaslist

