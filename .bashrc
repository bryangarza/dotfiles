#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoredups:erasedups
export EDITOR=vim
export HISTSIZE=10000
export LC_ALL=
export LC_COLLATE="C"
# After each command, save and reload history
export PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND:-:}"
set -o vi
shopt -s histappend


prompt() {
    while true; do
        read -p "$@ [Y/n] " yn
        case $yn in
            [Yy]* ) return 0
                ;;
            [Nn]* ) return 1
                ;;
            *) echo 'invalid answer' >&2
                ;;
        esac
    done
}

colorlist() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

tputcolors() {
    echo
    echo -e "$(tput bold) reg  bld  und   tput-command-colors$(tput sgr0)"

    for i in $(seq 1 7); do
        echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
    done

    echo ' Bold            $(tput bold)'
    echo ' Underline       $(tput sgr 0 1)'
    echo ' Reset           $(tput sgr0)'
    echo
}

echocolors() {
    #   This file echoes a bunch of color codes to the 
    #   terminal to demonstrate what's available.  Each 
    #   line is the color code of one forground color,
    #   out of 17 (default + 16 escapes), followed by a 
    #   test use of that color on all nine background 
    #   colors (default + 8 escapes).

    T='gYw'   # The test text

    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m"

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m'
    do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
}

# quiet xev.
xevq() {
    xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
}

refup() {
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup && echo 'backed up mirrorlist...'
    sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist && echo 'latest mirror list retrieved.'
}

# core
alias c='clear'
alias ls='ls --color=always'
alias la='ls -AF'
alias ll='ls -l'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'
alias cr='cp -rv'
alias rr='rm -rv'
alias off='echo Shutdown; sudo shutdown -h now'
alias offr='echo Reboot; sudo shutdown -r now'

# git
alias gs='git status'
alias gp='git push origin'
alias gd='git diff'
alias gc='git commit -v'
alias gco='git checkout'
alias gcp='git commit -a -v && git push origin'
alias gb='git branch'

# vim
alias v='vim'
alias vd='vimdiff'
alias vt='vim ~/.tmux.conf'
alias vdwm="vim ~/dwm/config.h && prompt 'remake?' && cd ~/dwm && makepkg -efi --skipinteg ;cd ~"
alias vv='vim ~/.vimrc'
alias vbr='. ~/.bashrc && echo "sourced ~.bashrc"'
alias vb='vim ~/.bashrc'

# apps
alias weechat='weechat-curses'
alias enpois='envee -A poison -a g -l w -d r -s WM=dwm -s Font=Artwiz-Lime/Termsyn'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias makedwm='makepkg -efi --skipinteg'
alias inst='sudo pacman -Syu --needed'
alias rem='sudo pacman -Rns'
alias pacup='sudo pacman -Syu'

# misc
alias mapcaps='xmodmap -e "clear lock"; xmodmap -e "keycode 0x42 = Escape"'
alias unmapcaps='xmodmap -e "keycode 0x42 = Caps_Lock"; xmodmap -e "add lock = Caps_Lock"'
alias dpmson='xset +dpms; xset s on'
alias dmpsoff='xset -dpms; xset s off'
alias dpms='xset -q | tail --lines=3'


# From https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# Reset
NC='\e[0m'              # Text Reset
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
IY='\e[0;93m'           # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

get_tot() {
    echo "$(($(find . -maxdepth 1 | wc -l)-1))"
}

get_hid() {
    echo "$(($(find . -maxdepth 1 -iname '.*' | wc -l)-1))"
}

PS1="\w ${IY}\$(get_tot)${NC} "
export PS1
