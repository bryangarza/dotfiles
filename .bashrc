#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# avoid duplicates
export HISTCONTROL=ignoredups:erasedups
export TERM=xterm-256color
export EDITOR=vim
export HISTSIZE=10000

set -o vi
# append history entries
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND:-:}"

# Change directory, list all files.
dc(){
    cd ${1:-$HOME}
    ls -aF --color=always
}

# map caps to esc
mapcaps(){
    xmodmap -e "clear lock"
    xmodmap -e "keycode 0x42 = Escape"
    echo mapcaps: caps-lock set to Escape via xmodmap
}
unmapcaps(){
    xmodmap -e "keycode 0x42 = Caps_Lock"
    xmodmap -e "add lock = Caps_Lock"
    echo unmapcaps: caps-lock set to caps-lock via xmodmap
}

# Disable/enable DPMS and screen saver.
dpms() {
    if [[ $1 = "on" ]]
    then
        xset +dpms
        xset s on
    elif [[ $1 = "off" ]]
    then
        xset -dpms
        xset s off
    elif [[ $1 = "info" ]]
    then
        dpms_query=`xset -q | tail --lines=3`
        echo "$dpms_query"
    fi
}

vb() {
    if [[ $1 = "r" ]]
    then
        . ~/.bashrc
        echo "sourced ~/.bashrc"
    else
        CURRENT=$PWD
        vim ~/.bashrc
        cd $CURRENT
    fi
}

vp() {
    if [[ $1 = "r" ]]
    then
        . ~/.bash_profile
        echo "sourced ~/.bash_profile"
    else
        CURRENT=$PWD
        vim ~/.bash_profile
        cd $CURRENT
    fi
}

vx() {
    CURRENT=$PWD
    vim ~/.Xresources
    cd $CURRENT
}

vv() {
    CURRENT=$PWD
    cd $HOME
    vim ~/.vimrc
    cd $CURRENT
}

# Saner, quieter xev.
xevq() {
    xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
}

function refup {
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    echo 'backed up mirrorlist...'
    sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist
    echo 'latest mirror list retrieved.'
}

function allup {
    refup
    sudo pacman -Syu
    aurget -Syu
}

# thanks graysky
function x {
	if [[ -f "$1" ]]; then
		case "$1" in
			*.lrz) lrztar -d "$1" && cd $(basename "$1" .lrz)
				;;
			*.tar.bz2) tar xjf "$1" && cd $(basename "$1" .tar.bz2)
				;;
			*.tar.gz)	tar xzf "$1" && cd $(basename "$1" .tar.gz)
				;;
			*.tar.xz)	tar Jxf "$1" && cd $(basename "$1" .tar.xz)
				;;
			*.bz2) bunzip2 "$1" && cd $(basename "$1" .bz2)
				;;
			*.rar) rar x "$1" && cd $(basename "$1" .rar)
				;;
			*.gz)	gunzip "$1" && cd $(basename "$1" .gz)
				;;
			*.tar) tar xf "$1" && cd $(basename "$1" .tar)
				;;
			*.tbz2) tar xjf "$1" && cd $(basename "$1" .tbz2)
				;;
			*.tgz) tar xzf "$1" && cd $(basename "$1" .tgz)
				;;
			*.zip) unzip "$1" && cd $(basename "$1" .zip)
				;;
			*.Z) uncompress "$1" && cd $(basename "$1" .Z)
				;;
			*.7z) 7z x "$1" && cd $(basename "$1" .7z)
				;;
			*) echo "don't know how to extract '$1'..."
				;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

alias ls='ls --color=always'
alias la='ls -AF'	# show hidden files, denotes dirs, exes

alias inst='sudo pacman -S --needed'
alias aurs='aurget -S'
alias aurup='aurget -Syu'
alias pacup='sudo pacman -Syu'

alias ca='clear; la'
alias c='clear'

alias rm='rm -v'
alias rr='rm -rv'

alias cp='cp -v'
alias cr='cp -rv'

alias mv='mv -v'

alias off='echo Shutdown; sudo shutdown -h now'
alias offr='echo Reboot; sudo shutdown -r now'

alias gs='git status'
alias gp='git push origin master'
alias gd='git diff'
alias gc='git commit -a -v && git push origin master'
alias renamerepo="echo -e \"rename at github.com\ngit remote rm origin\ngit remote add\
 origin git@github.com:[USERNAME]/[PROJECT_NAME].git\""

alias makedwm='makepkg -efi --skipinteg'
alias v='vim'
alias weechat='weechat-curses'
alias enpois='envee -A poison -a g -l w -d r -s WM=dwm -s Font=Artwiz-Lime/Terminus'

# From https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# Reset
NC='\e[0m'       # Text Reset
# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
# High Intensty
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

#PS1="${NC}[${IYellow}\w${NC}] has ${IYellow}\$((\$(find . -maxdepth 1 | wc -l) - 1))${NC} total files,\
# ${IYellow}\$((\$(find . -maxdepth 1 | wc -l) - \$(find . -maxdepth 1 ! -name \.\* | wc -l)))${NC} hidden,\
# ${IYellow}\$(find . -maxdepth 1 -type f -perm -u+rx | wc -l)${NC} executable.\n${IYellow}\$${NC} "
PS1="[${IGreen}\w${NC}] [${IYellow}\$((\$(find . -maxdepth 1 | wc -l) - 1))${NC}] ${White}\$${NC} "
export PS1
