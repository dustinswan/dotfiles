xrdb ~/.Xresources &
setxkbmap -layout dvorak
# -option ctrl:nocaps
xmodmap .Xmodmap &
xcape &
urxvtd -q -o -f &
compton &
xsetroot -solid black -cursor_name left_ptr &

eval $(gpg-agent --daemon) &

/usr/bin/xscreensaver -no-splash &

dropboxd &

feh --bg-fill ~/Dropbox/Photos/wallpaper/cycloid.gif
# ~/dotfiles/bin/animated_wallpaper.sh ~/Dropbox/Photos/wallpaper/cycloid.gif &

exec xmonad
