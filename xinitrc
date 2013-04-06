xrdb ~/.Xresources &
setxkbmap dvorak
setxkbmap -option ctrl:nocaps
xsetroot -cursor_name left_ptr &
xmodmap .Xmodmap &
urxvtd -q -o -f &
#compton -cGb &
compton &

dropboxd &

feh --bg-fill ~/Dropbox/Photos/wallpaper/cycloid.gif
# gifview --animate --new-window root ~/Dropbox/Photos/wallpaper/cycloid.gif

exec xmonad
