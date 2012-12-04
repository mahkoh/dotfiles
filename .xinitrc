# set keymap to 'programmer's dvorak'
setxkbmap us dvp

# enable ctrl-alt-backspace
setxkbmap -option terminate:ctrl_alt_bksp

# custom keymap changes
xmodmap .xmodmap

# set standard cursor
xsetroot -cursor_name left_ptr

# set background
xloadimage -onroot /home/julian/pictures/Wallpaper/leafs.png

# load fonts
xset +fp /usr/share/fonts/local/
xset fp rehash

# set keyboard repeat rate to 250
xset r rate 250

# hide cursor
unclutter &

# terminal daemon
urxvtd -q &

exec xmonad
