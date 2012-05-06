#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:$HOME/bin
export PATH

export dwmstatus_aur="^DAur^C $(cower -u | wc -l)"
export dwmstatus_upd="^DUpd^C $(pacman -Qqu --dbpath /tmp/checkup-db-prole/ | wc -l)"
