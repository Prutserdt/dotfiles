# ~/.bashrc
#   _               _              
#  | |__   __ _ ___| |__  _ __ ___ 
#  | '_ \ / _` / __| '_ \| '__/ __|
# _| |_) | (_| \__ \ | | | | | (__ 
#(_)_.__/ \__,_|___/_| |_|_|  \___|
#             Modified by Prutserdt

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Display arch logo (asci art) and additional info in terminal
pfetch

# Change the size of the bash history to 5000 in memory (500 is default) 
# and the total amount of maximally saved lines
HISTSIZE=5000
HISTFILESIZE=10000
# Do not add duplicate entries and no spaces; erase duplicates
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

###########################
#        Alias list       #
###########################
# Helpfile to show all of the aliases if this .bashrc in shell
alias ?="c && echo AN OVERVIEW OF ALL OF THE ALIASES DEFINED IN .basrc && 
echo --------------------------------------------------- &&
grep -e alias*=* ~/.bashrc | grep -v '#'| sed -e 's/\<alias\>//g'
echo ---------------------------------------------------"
# Colored output when possible
alias ls='ls --color=auto'
alias diff="diff --color=auto"
# Lazy man's ls
alias l='ls -al'
# Exiting quickly
alias q="exit"
# Clear screen quickly
alias c="clear"
# Clear screen and show content
alias cls="clear;ls"
# Clear screen and show content
alias cl="clear;l"
# Fuzzy find history
alias h="history | fzf"
# History executable. https://superuser.com/questions/7414/how-can-i-search-the-bash-history-and-rerun-a-command
alias hx='eval $(history | sed "s/^ *[0-9]* *//g" | fzf --tac --tiebreak=index)'
# Fuzzy find in the most recent i3_log file 
alias fzlog='fzf < ~/i3_log/"$(ls -Art ~/i3_log | tail -n1)"'
# sxiv shortcut: open thumbnail mode in current directory and show jpeg, jpg,
# gif, and png files. Sort by name and give output if files are selected (m).
# alias s="find . -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sxiv * -fbto"
alias s="find . -maxdepth 1 -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sort | sxiv -ftio"
# Including underlaying subdirectories
alias S="find . -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'| sxiv -ftio"
# Jump to direcotories
alias da="cd ~/Stack/Afbeeldingen && pwd"
alias daw="cd ~/Stack/Afbeeldingen/Wallpapers && pwd"
alias dav="cd ~/Stack/Afbeeldingen/Vakantie && pwd"
alias dc="cd ~/.config && pwd"
alias dd="cd ~/Downloads && pwd"
alias dh="cd ~/ && pwd"
alias ds="cd ~/Stack && pwd"
alias dw="cd ~/Stack/Afbeeldingen/Wallpapers && pwd"
alias de="cd ~/Stack/Documenten/Studie/C_programming_training_Dartmouth && pwd"
# Jump to suckless applications, d+xx/d+sxx (xx=application,sxx=application in Stack backups)
alias dss="cd ~/Stack/suckless && pwd"
alias ddw="cd ~/suckless/dwm && pwd"
alias dsdw="cd ~/Stack/suckless/dwm && pwd"
alias dst="cd ~/suckless/st && pwd"
alias dsst="cd ~/Stack/suckless/st && pwd"
alias dsu="cd ~/suckless/surf && pwd"
alias dssu="cd ~/Stack/suckless/surf && pwd"
alias ddm="cd ~/suckless/dmenu && pwd"
alias dsdm="cd ~/Stack/suckless/dmenu && pwd"
# Dotfiles repository.
# Starts with a status check and after that gives some options to push/pull.
alias dotfiles='~/.config/dotfiles.sh'
# OLD
# config: simplifying communication with GIT
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# Reset keyboard modkeys and swap Caps/Esc, plus blazingly fast key repeats.
# After hotswapping keyboards the settings can be restored by this alias.
alias k='xmodmap ~/.config/kbswitch && xset r rate 300 80'

###########################
#           dwm           # 
###########################
PATH="$HOME/bin:$PATH" # ~/bin was addet to path, makes locale install of dwm possible via .xinitrc.
# Make the current dwm the stable version
alias dwmbackup="rm -r ~/Stack/suckless/dwm/dwm-6.2_stable/* && cp -r ~/suckless/dwm/* ~/Stack/suckless/dwm/dwm-6.2_stable"
# Go back to vanilla dwm. DESTROYS CURRENT dwm!
alias dwmvanilla="rm -r ~/suckless/dwm && mkdir ~/suckless/dwm && cp -r ~/Stack/suckless/dwm/dwm-6.2_20200512_vanilla/* ~/suckless/dwm && cd ~/suckless/dwm && clear && ls -al"
# Go back to stable dwm. DESTROYS CURRENT dwm!
alias dwmstable="rm -r ~/suckless/dwm && mkdir ~/suckless/dwm && mkdir ~/suckless/dwm/log && cp -r ~/Stack/suckless/dwm/dwm-6.2_stable/* ~/suckless/dwm && cd ~/suckless/dwm && clear && ls -al"
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory: rm ~/Stack/dwm/patches/test/*  
# 2: Place the diff file to be tested in the test directory: cp  ~/Stack/dwm/patches/example.diff ~/Stack/dwm/patches/test*
# 3: Run the dwmpatch command to test the patch
#alias dwmvanillapatch="dwmvanilla && cp ~/dwm/config.h ~/dwm/config.def.h && rm ~/dwm/config.h && patch -p1 < ~/Stack/dwm/patches/test/*.diff && make clean install"
alias dwmpatch="dwmstable && ls ~/Stack/suckless/dwm/patches/test/*.diff >> ~/suckless/dwm/log/diff_log && cp -r ~/suckless/dwm/config.h ~/suckless/dwm/config.def.h && rm ~/suckless/dwm/config.h && patch -p1 < ~/Stack/suckless/dwm/patches/test/*.diff && make clean install"

###########################
#           st            # 
###########################
# requirement: PATH="$HOME/bin:$PATH" 
# Make the current st the stable version
alias stbackup="rm -r ~/Stack/suckless/st/st-0.8.3_stable && mkdir ~/Stack/suckless/st/st-0.8.3_stable && cp -r ~/suckless/st/* ~/Stack/suckless/st/st-0.8.3_stable"
# Go back to vanilla st. DESTROYS CURRENT st!
alias stvanilla="rm -r ~/suckless/st && mkdir ~/suckless/st && cp -r ~/Stack/suckless/st/st-0.8.3_vanilla/* ~/suckless/st && cd ~/suckless/st && clear && ls -al"
# Go back to stable st. DESTROYS CURRENT st!
alias ststable="rm -r ~/suckless/st && mkdir ~/suckless/st && cp -r ~/Stack/suckless/st/st-0.8.3_stable/* ~/suckless/st && cd ~/suckless/st && clear && ls -al"
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory: rm ~/Stack/dwm/patches/test/*  
# 2: Place the diff file to be tested in the test directory: cp  ~/Stack/dwm/patches/example.diff ~/Stack/dwm/patches/test*
# 3: Run the dwmpatch command to test the patch
alias stpatch="ststable && ls ~/Stack/suckless/st/patches/test/*.diff >> ~/suckless/st/log/diff_log && cp -r ~/suckless/st/config.h ~/suckless/st/config.def.h && rm ~/suckless/st/config.h && patch -p1 < ~/Stack/suckless/st/patches/test/*.diff && make clean install"

###########################
#           dmenu         # 
###########################
# requirement: PATH="$HOME/bin:$PATH" 
# Make the current dmenu the stable version
alias dmenubackup="rm -r ~/Stack/suckless/dmenu/dmenu-4.9_stable && mkdir ~/Stack/suckless/dmenu/dmenu-4.9_stable && cp -r ~/suckless/dmenu/* ~/Stack/suckless/dmenu/dmenu-4.9_stable"
# Go back to vanilla st. DESTROYS CURRENT dmenu!
alias dmenuvanilla="rm -r ~/suckless/dmenu && mkdir ~/suckless/dmenu && cp -r ~/Stack/suckless/dmenu/dmenu-4.9_vanilla/* ~/suckless/dmenu && cd ~/suckless/dmenu && clear && ls -al"
# Go back to stable dmenu. DESTROYS CURRENT dmenu!
alias dmenustable="rm -r ~/suckless/dmenu && mkdir ~/suckless/dmenu && cp -r ~/Stack/suckless/dmenu/dmenu-4.9_stable/* ~/suckless/dmenu && cd ~/suckless/dmenu && clear && ls -al"
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory: rm ~/Stack/dwm/patches/test/*  
# 2: Place the diff file to be tested in the test directory: cp  ~/Stack/dwm/patches/example.diff ~/Stack/dwm/patches/test*
# 3: Run the dwmpatch command to test the patch
alias dmenupatch="dmenustable && ls ~/Stack/suckless/dmenu/patches/test/*.diff >> ~/suckless/dmenu/log/diff_log && cp -r ~/suckless/dmenu/config.h ~/suckless/dmenu/config.def.h && rm ~/suckless/dmenu/config.h && patch -p1 < ~/Stack/suckless/dmenu/patches/test/*.diff && make clean install"

###########################
#           surf          # 
###########################
# requirement: PATH="$HOME/bin:$PATH" 
# Make the current surf the stable version
alias surfbackup="rm -r ~/Stack/suckless/surf/surf-2.0_stable && mkdir ~/Stack/suckless/surf/surf-2.0_stable && cp -r ~/suckless/surf/* ~/Stack/suckless/surf/surf-2.0_stable"
# Go back to vanilla st. DESTROYS CURRENT surf!
alias surfvanilla="rm -r ~/suckless/surf && mkdir ~/suckless/surf && cp -r ~/Stack/suckless/surf/surf-2.0_vanilla/* ~/suckless/surf && cd ~/suckless/surf && clear && ls -al"
# Go back to stable surf. DESTROYS CURRENT surf!
alias surfstable="rm -r ~/suckless/surf && mkdir ~/suckless/surf && cp -r ~/Stack/suckless/surf/surf-2.0_stable/* ~/suckless/surf && cd ~/suckless/surf && clear && ls -al"
# Patch automation. THIS WIL DELETE ALL dwm DIRECTORY FILES!
# 1: delete files in test directory: rm ~/Stack/suckless/surf/patches/test/*  
# 2: Place the diff file to be tested in the test directory: cp ~/Stack/suckless/surf/patches/example.diff ~/Stack/dwm/patches/test*
# 3: Run the dwmpatch command to test the patch
alias surfpatch="surfstable && ls ~/Stack/suckless/surf/patches/test/*.diff >> ~/suckless/surf/log/diff_log && cp -r ~/suckless/surf/config.h ~/suckless/surf/config.def.h && rm ~/suckless/surf/config.h && patch -p1 < ~/Stack/suckless/surf/patches/test/*.diff && make clean install"
