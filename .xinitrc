#!/bin/sh

setxkbmap -print mydvp | xkbcomp -I$HOME/.xkb/ - $DISPLAY
# set keymap to 'programmer's dvorak'
# setxkbmap us dvp

# enable ctrl-alt-backspace
# setxkbmap -option terminate:ctrl_alt_bksp

# custom keymap changes
# xmodmap ~/.xmodmaprc

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

# hide cursor
unclutter -reset &

# enable numlock
numlockx

systemctl --user start spotblock &
systemctl --user start status &

i3
exit

# exec xmonad
while true; do
    dwm
    sleep .5
done
