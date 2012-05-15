#!/bin/sh
#
# ~/.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

. ~/.bash_profile

xset +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts
xset fp rehash

xmodmap -e "clear lock"
xmodmap -e "keycode 0x42 = Escape"
xbindkeys

xset -dpms
xset s off

xrdb ~/.Xresources
    
hsetroot -center ~/images/skysun.jpg
unclutter -idle 10 -jitter 5 &
~/bin/dwmstatus &
urxvtd -q -o -f
exec dwm
