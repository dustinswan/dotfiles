import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)

import XMonad.Util.Run (spawnPipe) -- for spawnPipe and hPutStrLn
import qualified System.IO

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers

lightBlue      = "#66aaff"
darkBlue       = "#0000cc"
lightGray      = "#aaaaaa"
darkGray       = "#444444"
dzenForeground = "#ffffff"
dzenBackground = "#000000"
myModMask      = mod4Mask -- command

myManageHook = composeAll
    [ resource =? "visimeet"   --> doFloat
    , resource =? "feh"        --> doFloat
    , isFullscreen --> doFullFloat
    ]

--myWorkspaces =  [ "!" , "@" , "#" , "$" , "%", "^^", "&", "*", "(" ]
--myWorkspaces =  [ "1" , "2" , "3" , "4" , "5", "6", "7", "8", "9" ]
--myWorkspaces =  [ "α" , "β" , "γ" , "δ" , "ε", "ζ", "η", "θ", "ι" ]
myWorkspaces =  [ "1" , "2" , "3" , "Ë" , "ê", "®", "7", "8", "9" ]

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = darkBlue

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myStatusBar = "conky -c /home/dustinswan/.conky | dzen2 -x '640' -w '640' -ta 'r' -y '0' -bg '#000000'"

myLogHook h = dynamicLogWithPP $ defaultPP
    { -- ppCurrent         = (">" ++)
      --ppCurrent         = dzenColor lightBlue dzenBackground . wrap "" " "
      ppCurrent         = dzenColor lightBlue dzenBackground . wrap "Ø" ""
    , ppVisible         = ("." ++)
    , ppHidden          = dzenColor lightGray dzenBackground . wrap " " ""
    , ppHiddenNoWindows = dzenColor darkGray dzenBackground . wrap " " ""
    , ppLayout          = (\_ -> "") -- TODO I suck at haskell
    , ppOutput          = System.IO.hPutStrLn h
    , ppTitle           = shorten 20
    , ppSep             = "  "
    , ppWsSep           = " "
    --, ppExtras        = [ date "%a %d %b" ]
    }

main = do
    dzenLeftBar <- spawnPipe "dzen2 -w '640' -ta 'l'"
    spawn myStatusBar
    xmonad $ defaultConfig
        { terminal           = "urxvtc"
        , focusFollowsMouse  = myFocusFollowsMouse
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        -- hooks
        , layoutHook         = avoidStruts $ layoutHook defaultConfig
        , manageHook         = myManageHook
        , logHook            = myLogHook dzenLeftBar
        }
        `additionalKeysP`
        [ ("M-p", spawn "dmenu_run -fn 'Tamsynmod:Regular:pixelsize=14'")
        , ("M-S-p", spawn "scrot")
        , ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 3%+")
        , ("<XF86AudioLowerVolume>", spawn "amixer sset Master 3%-")
        , ("<XF86AudioMute>", spawn "amixer sset Master toggle")
        , ("<XF86Eject>", spawn "eject")
        ]
