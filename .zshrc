# ~/.zshrc
#           _
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
# _ / /\__ \ | | | | | (__
#(_)___|___/_| |_|_|  \___|
#     modified by Prutserdt

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="$HOME/bin:$PATH" # ~/bin was addet to path, makes locale install of dwm possible via .xinitrc.

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# "Theming"
#
# Based on the xiong-chiamiov-plus.szh-theme, from oh-mh-zsh.
# user, host, full path, and time/date on two lines for easier vgrepping
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%a %b %d, %H:%M"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
# ZSH_THEME="random" # (this will pick random themes from oh-my-zsh
# To know which specific one was loaded, run: echo $RANDOM_THEME
pfetch                # Display arch logo (asci art) and additional info in terminal
cowthink $(fortune)   # Let the cow quote! (requires conwsay and fortune-mod)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
# thefuck # does not seem to work...?
  colored-man-pages
  z
  )

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' file-sort name
zstyle :compinstall filename '/home/icefly/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# todo: do not add duplicates to history

zstyle ':completion:*' menu select # arrow keys for selection autocomplete interface

setopt COMPLETE_ALIASES #autocomplete command line switches for aliases

zstyle ':completion::complete:*' gain-privileges 1 #autocomplete for sudo

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
#bindkey -v


###########################
#        Alias list       #
###########################
#alias ?="c && echo AN OVERVIEW OF ALL OF THE ALIASES DEFINED IN .basrc && 
#echo --------------------------------------------------- &&
#grep -e alias*=* ~/.bashrc | sed -e 's/\<alias\>//g'
#echo ---------------------------------------------------"
alias .1='cd ..'
alias .2='cd ../.. && pwd'
alias .3='cd ../../.. && pwd'
alias .4='cd ../../../.. && pwd'
alias ls='ls --color=auto'      # Colored output when possible
alias diff="diff --color=auto"
alias l='ls -alh'               # Lazy man's ls
alias q="exit"                  # Exiting quickly
alias c="clear"                 # Clear screen quickly
alias cls="clear;ls"            # Clear screen and show content
alias cl="clear;l"              # Clear screen and show content
# uitzoeken hoe history te gebruiken met , misschien bash en zsh sourcen?
#
#
##alias h="history | fzf"         # Fuzzy find history
alias h="/home/icefly/.zsh_history | fzf"         # Fuzzy find history
alias hx='eval $(history | sed "s/^ *[0-9]* *//g" | fzf --tac --tiebreak=index)' # History executable
#
#
#
alias fzlog='fzf < ~/i3_log/"$(ls -Art ~/i3_log | tail -n1)"' # Fuzzy find in the most recent i3_log file 
# sxiv: thumbnail mode current directory. Sort by name and give output if files are selected (m)
alias s="find . -maxdepth 1 -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sort | sxiv -ftio"
# sxiv: including underlaying subdirectories
alias S="find . -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sxiv -ftio"
alias dotfiles='~/.config/dotfiles.sh'                                  # Dotfiles repository Github
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' # Github simplification
alias k='xmodmap ~/.config/kbswitch && xset r rate 300 80'              # Change modkeys, Caps/Esc and fast key repeats
alias r='xmodmap ~/.config/rdxswitch && xset r rate 300 80'             # Change to redox kb, alt-r modkeys, and fast key repeats
# Jump to directories
alias daa="cd ~/Stack/Documenten/Aandelen"
alias daf="cd ~/Stack/Afbeeldingen"
alias dav="cd ~/Stack/Afbeeldingen/Vakantie"
alias daw="cd ~/Stack/Afbeeldingen/Wallpapers"
alias dc="cd ~/.config"
alias dd="cd ~/Downloads"
alias dh="cd ~/"
alias ds="cd ~/Stack"
alias dw="cd ~/Stack/Afbeeldingen/Wallpapers"
alias de="cd ~/Stack/Documenten/Studie/C_programming_training_Dartmouth"
alias dr="cd ~/qmk_firmware/keyboards/redox/keymaps/Prutserdt"
alias dg="cd ~/qmk_firmware/keyboards/gergo/keymaps/Prutserdt"
# Jump to suckless app dirs, d+xx/d+sxx (xx=application,sxx=application in Stack backups)
alias dss="cd ~/Stack/suckless"
alias ddw="cd ~/.config/suckless/dwm"
alias dsdw="cd ~/Stack/suckless/dwm"
alias ddm="cd ~/.config/suckless/dmenu"
alias dsdm="cd ~/Stack/suckless/dmenu"
# zsh aliases
alias ze="vim ~/.zshrc"
alias zs="source ~/.zshrc"
###########################
#           dwm           # 
###########################
#PATH="$HOME/bin:$PATH" # ~/bin was addet to path, makes locale install of dwm possible via .xinitrc.
alias dwmbackup='~/.config/dwmbackup.sh'        # Make the current dwm the stable version
alias dwmvanilla='~/.config/dwmvanilla.sh'      # Go back to vanilla dwm. DESTROYS CURRENT dwm!
alias dwmstable='~/.config/dwmstable.sh'        # Go back to stable dwm. DESTROYS CURRENT dwm!
alias dwmpatch='~/.config/dwmpatch.sh'          # Restore dwmstable and run the patch on it
###########################
#           dmenu         # 
########################### requirement: PATH="$HOME/bin:$PATH" 
alias dmenubackup='~/.config/dmenubackup.sh'    # Make the current dmenu the stable version
alias dmenuvanilla='~/.config/dmenuvanilla.sh'  # Go back to vanilla st. DESTROYS CURRENT dmenu!
alias dmenustable='~/.config/dmenustable.sh'    # Go back to stable dmenu. DESTROYS CURRENT dmenu!
alias dmenupatch='~/.config/dmenupatch.sh'      # 3: Run the dwmpatch command to test the patch
###########################
