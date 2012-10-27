[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap dvorak
setxkbmap -option ctrl:nocaps

compton -cGb

dropboxd &

 random background
while true;
do
  awsetbg -c -r ~/Dropbox/Photos/wallpaper
  sleep 1m
done &

exec awesome
