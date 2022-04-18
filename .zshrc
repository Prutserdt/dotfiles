# ~/.zshrc  _
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
# _ / /\__ \ | | | | | (__
#(_)___|___/_| |_|_|  \___|
#     modified by Prutserdt

###########################
#     Basic config        #
###########################
export PATH="$HOME/bin:$PATH" # ~/bin added, for local dwm install by .xinitrc.

# TODO: do not add duplicates to history
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

setopt HIST_REDUCE_BLANKS  ## Delete empty lines from history file

###########################
#         My theme        #
###########################
# Based on the xiong-chiamiov-plus.szh-theme, from oh-mh-zsh.
# user, host, full path, and time/date on two lines for easier grepping
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%a %b %d, %H:%M"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B %{\e[0m%}%b'
# 17APR22: line above added and lines below removed:
# #%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '
#PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

pfetch              # Display arch logo (asci art) and additional sys info
cowthink $(fortune) # Let the cow quote! (requires conwsay and fortune-mod)

###########################
#     oh-my-zsh stuff     #
###########################
ZSH=/usr/share/oh-my-zsh/ # Path to the oh-my-zsh installation.

DISABLE_AUTO_UPDATE="true" # Uncomment to disable bi-weekly auto-update checks

plugins=(
  thefuck           # corrects previous commands, by Esc-Esc
#  autojump          # Jump faster to dirs; j foo
  colored-man-pages # Increase readibility of man pages, by...
  vi-mode           # Vi-like bindings. (Esc: normal mode, i: insert, etc)
  fzf               # fuzzy find
  zsh-autosuggestions # Does not work, gitinstall performed by github oh my zsh procedure, after a git clone and adding this line...
  )

bindkey -v          # enabling vi bindings, dependency: vi-mode plugin
# VI_MODE_SET_CURSOR=true # change cursor style after switching input mode,
# does not work... strange...

export FZF_BASE=/usr/share/fzf

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
###########################
#   Sourcing of sources   #
###########################
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.aliases
# zsh-autosuggestions. Leads to cursor vanishing in alacrity. Strange....
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
