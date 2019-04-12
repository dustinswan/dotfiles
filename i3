set $mod Mod4
gaps inner 10
gaps outer 0
smart_borders on

for_window [class="^.*"] border pixel 0
new_window pixel 1

for_window [class="mpv"] floating enable
for_window [class="mpv"] resize set 1500px 1000px
for_window [class="mpv"] move absolute position center

for_window [class="feh"] floating enable
for_window [class="feh"] resize set 1500px 1000px
for_window [class="feh"] move absolute position center

font pango:Iosevka Nerd Font Regular 8

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# kill focused window
bindsym $mod+Shift+q kill

# bindsym $mod+Return exec i3-sensible-terminal
bindsym $mod+Return exec alacritty
bindsym $mod+e exec dmenu_run
bindsym $mod+space exec "rofi -show combi"
bindsym $mod+Shift+e exec "emacsclient -c"
bindsym $mod+Shift+b exec "firefox"
bindsym XF86AudioRaiseVolume exec "amixer -q sset Master,0 1+ unmute"
bindsym XF86AudioLowerVolume exec "amixer -q sset Master,0 1- unmute"
bindsym XF86AudioMute exec "amixer -q sset Master,0 toggle"
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Tab focus right
bindsym $mod+Shift+Tab focus left

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+apostrophe split h

# split in vertical orientation
bindsym $mod+minus split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+comma layout tabbed
bindsym $mod+period layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+Ctrl+space focus mode_toggle

# focus the parent container
bindsym $mod+p focus parent

# focus the child container
bindsym $mod+c focus child

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10

# reload the configuration file
bindsym $mod+Shift+r reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+c restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+period exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

mode "resize" {
        bindsym h resize shrink width 2 px or 2 ppt
        bindsym k resize grow height 2 px or 2 ppt
        bindsym j resize shrink height 2 px or 2 ppt
        bindsym l resize grow width 2 px or 2 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+p mode "default"
}

bindsym $mod+r mode "resize"
