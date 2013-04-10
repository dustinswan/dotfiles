xrdb ~/.Xresources &
setxkbmap dvorak
setxkbmap -option ctrl:nocaps
xsetroot bg black -cursor_name left_ptr &
xmodmap .Xmodmap &
urxvtd -q -o -f &
#compton -cGb &
compton &

dropboxd &

feh --bg-fill ~/Dropbox/Photos/wallpaper/cycloid.gif
# ~/dotfiles/bin/animated_wallpaper.sh ~/Dropbox/Photos/wallpaper/cycloid.gif &

exec xmonad
