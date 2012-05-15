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
xmodmap
xset -dpms
xset s off
xrdb ~/.Xresources
xbindkeys
    
~/bin/dwmstatus &
unclutter -idle 10 -jitter 5 &
hsetroot -center ~/images/skysun.jpg
urxvtd -q -o -f
exec dwm
