#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -print mydvp | xkbcomp -I$HOME/.xkb/ - $DISPLAY
# set keymap to 'programmer's dvorak'
# setxkbmap us dvp

# enable ctrl-alt-backspace
# setxkbmap -option terminate:ctrl_alt_bksp

# custom keymap changes
# xmodmap ~/.xmodmaprc

xcape -e 'Shift_L=space'

# set standard cursor
xsetroot -cursor_name left_ptr

# set background
#xloadimage -onroot /home/julian/pictures/wallpaper/wp.jpg
xsetroot -solid "#001019"

# load fonts
xset +fp /usr/share/fonts/local/
xset fp rehash

# set keyboard repeat rate to 250
xset r rate 250

# enable tap
xinput set-prop 'ETPS/2 Elantech Touchpad' 'libinput Tapping Enabled' 1

# double tap is middle click
xinput set-prop 'ETPS/2 Elantech Touchpad' 'libinput Tapping Button Mapping Enabled' 0 1

# mouse acceleration
# xinput set-prop 'ETPS/2 Elantech Touchpad' 'libinput Accel Speed' 0.2

# hide cursor
unclutter -b

# enable numlock
numlockx

export QT_QPA_PLATFORMTHEME=kde

systemctl --user start spotblock &
# systemctl --user start status &

# startkde
# exit

i3
exit

# exec xmonad
while true; do
    dwm
    sleep .5
done
