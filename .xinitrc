#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# For terminus/artwiz-fonts fonts:
xset +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts
xset fp rehash

# run xmodmap settings, map caps to esc
if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

# run unclutter background process, hides mouse
# urxvt client daemon
urxvtd -q -o -f

# Disable/enable DPMS and screen saver
xset -dpms
xset s off

# Synchronize clipboards.
# Bleh!
#autocutsel -fork &
#autocutsel -selection PRIMARY -fork &

# Use instead of ~/.Xdefaults
xrdb ~/.Xresources
xbindkeys
    
while true; do ~/bin/dwmstatus; sleep 1s; done &
unclutter -idle 10 -jitter 5 &
# Set wallpaper (example)
#feh --bg-scale ~/.xwallpaper-dwm.png
exec dwm
