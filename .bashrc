# ~/.bashrc
#   _               _              
#  | |__   __ _ ___| |__  _ __ ___ 
#  | '_ \ / _` / __| '_ \| '__/ __|
# _| |_) | (_| \__ \ | | | | | (__ 
#(_)_.__/ \__,_|___/_| |_|_|  \___|
#             Modified by Prutserdt
[[ $- != *i* ]] && return           # If not running interactively, don't do anything
PS1='[\u@\h \W]\$ '
PROMPT_COMMAND='printf "\033]0;[%s@%s]$ %s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/"~"}"' # Make windowname: [user@host]$ directory 
pfetch                              # Display arch logo (asci art) and additional info in terminal
cowthink $(fortune)                 # Let the cow quote! (requires conwsay and fortune-mod)
HISTSIZE=5000                       # Make size of bash history 5000 (500= default) 
HISTFILESIZE=10000                  # and the total amount of maximally saved lines
HISTCONTROL=ignoredups:erasedups    # Do not add duplicate entries and no spaces
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
###########################
#        Alias list       #
###########################
alias ?="c && echo AN OVERVIEW OF ALL OF THE ALIASES DEFINED IN .basrc && 
echo --------------------------------------------------- &&
grep -e alias*=* ~/.bashrc | sed -e 's/\<alias\>//g'
echo ---------------------------------------------------"
alias ls='ls --color=auto'          # Colored output when possible
alias diff="diff --color=auto"
alias l='ls -al'                    # Lazy man's ls
alias q="exit"                      #  Exiting quickly
alias c="clear"                     # Clear screen quickly
alias cls="clear;ls"                # Clear screen and show content
alias cl="clear;l"                  # Clear screen and show content
alias h="history | fzf"             # Fuzzy find history
alias hx='eval $(history | sed "s/^ *[0-9]* *//g" | fzf --tac --tiebreak=index)' # History executable
alias fzlog='fzf < ~/i3_log/"$(ls -Art ~/i3_log | tail -n1)"' # Fuzzy find in the most recent i3_log file 
# sxiv: thumbnail mode current directory. Sort by name and give output if files are selected (m).
alias s="find . -maxdepth 1 -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sort | sxiv -ftio"
# sxiv: including underlaying subdirectories
alias S="find . -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sxiv -ftio"
alias dotfiles='~/.config/dotfiles.sh'                                  # Dotfiles repository Github
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' # Github simpification
alias k='xmodmap ~/.config/kbswitch && xset r rate 300 80'              # Change modkeys, Caps/Esc and fast key repeats
alias r='xmodmap ~/.config/rdxswitch && xset r rate 300 80'             # Change to redox kb, alt-r modkeys, and fast key repeats
# Jump to directories/
alias daa="cd ~/Stack/Documenten/Aandelen && pwd"
alias daf="cd ~/Stack/Afbeeldingen && pwd"
alias dav="cd ~/Stack/Afbeeldingen/Vakantie && pwd"
alias daw="cd ~/Stack/Afbeeldingen/Wallpapers && pwd"
alias dc="cd ~/.config && pwd"
alias dd="cd ~/Downloads && pwd"
alias dh="cd ~/ && pwd"
alias ds="cd ~/Stack && pwd"
alias dw="cd ~/Stack/Afbeeldingen/Wallpapers && pwd"
alias de="cd ~/Stack/Documenten/Studie/C_programming_training_Dartmouth && pwd"
# Jump to suckless applications, d+xx/d+sxx (xx=application,sxx=application in Stack backups)
alias dss="cd ~/Stack/suckless && pwd"
alias ddw="cd ~/.config/suckless/dwm && pwd"
alias dsdw="cd ~/Stack/suckless/dwm && pwd"
alias ddm="cd ~/.config/suckless/dmenu && pwd"
alias dsdm="cd ~/Stack/suckless/dmenu && pwd"
###########################
#           dwm           # 
###########################
PATH="$HOME/bin:$PATH" # ~/bin was addet to path, makes locale install of dwm possible via .xinitrc.
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
