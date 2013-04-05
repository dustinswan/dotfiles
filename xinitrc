[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap dvorak
setxkbmap -option ctrl:nocaps

xsetroot -cursor_name left_ptr

dropboxd &

exec xmonad
