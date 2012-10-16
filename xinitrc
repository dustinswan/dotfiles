[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap -option ctrl:nocaps

#transparency and shadows
xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &

dropboxd &

# random background
while true;
do
  awsetbg -c -r ~/Dropbox/Photos/wallpaper
  sleep 1m
done &

# urxvt &

exec awesome
