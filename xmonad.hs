module Main where

import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
-- import System.Taffybar.Hooks.PagerHints (pagerHints)

lightBlue = "#66aaff"

main = xmonad $ docks $ ewmh $ defaultConfig
    { terminal = "urxvtc"
    , modMask = mod4Mask
    , workspaces = [ "1", "2", "3" ]
    , borderWidth = 2
    , normalBorderColor = "#000000"
    , focusedBorderColor = lightBlue
    , focusFollowsMouse = False
    , layoutHook = avoidStruts $ spacingWithEdge 6 $ layoutHook defaultConfig
    , startupHook = do
        spawn "polybar top"
        spawn "compton -cGb"
        spawn "~/dotfiles/logitech_linux_mouse.sh"
        spawn "xsetroot -solid black -cursor_name left_ptr"
        spawn "feh --bg-fill ~/Sync/Pictures/Wallpaper/space2.jpg"
        spawn "setxkbmap -option ctrl:nocaps -option compose:ralt"
        spawn "xcape -e 'Control_L=Escape'"
        spawn "qsyncthingtray"
        spawn "xscreensaver"
    }
    `additionalKeysP`
    [ ("M1-<Space>", spawn "rofi -show combi")
    , ("M-p", spawn "rofi -show combi")
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+")
    , ("C-M-M1-b", spawn "firefox")
    , ("C-M-M1-e", spawn "emacsclient -c")
    ]
