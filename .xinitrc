setxkbmap us dvp

xmodmap .xmodmaprc

xsetroot -cursor_name left_ptr
xloadimage -onroot -center /home/julian/pictures/NeverEvenClose1920x1080.png

xset +fp /usr/share/fonts/local/
xset fp rehash
xset r rate 250

unclutter &
urxvtd -q &
dropbox.py start &

exec xmonad
