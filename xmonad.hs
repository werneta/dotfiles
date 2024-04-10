import System.IO

import Data.Ratio

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers           -- for isFullscreen
import XMonad.Hooks.SetWMName
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Paste
import XMonad.Actions.CycleWS
import XMonad.Actions.WorkspaceNames
import XMonad.Actions.Warp

import Data.List
import Data.Time
import Data.Time.Clock.System
import Data.Time.Format

import qualified XMonad.StackSet as W

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Gnome-calculator" --> doFloat
    , className =? "Arandr"    --> doFloat
    , className =? "gksqt"     --> doFloat
    , appName   =? "Wave"      --> doFloat
    , stringProperty "_NET_WM_NAME"   =? "Never gonna run around and desert you" --> doFloat
    , stringProperty "_NET_WM_NAME"   =? "Camel by camel" --> doFloat
    , stringProperty "_NET_WM_NAME"   =? "Keyboard" --> doFloat
    , fmap ("SPaCeMusicW" `isInfixOf`) (stringProperty "_NET_WM_NAME")    --> doFloat
    , isFullscreen             --> doFloat
    ]

myLayout = ThreeColMid 1 (3/100) (1/2) ||| Full ||| tiled ||| Mirror tiled
    where tiled = Tall nmaster delta ratio
          nmaster = 1
          ratio = 1/2
          delta = 3/100

-- Use the "Windows" key as the modifier
modmask = mod4Mask

-- I require... 22 workspaces!
myWorkspaces = map show [1 .. 22 :: Int]

{- This one is tough.
 -
 - We're building a list of tuples (describing keys) and commands to execute.
 - This list handles absolute workspace addressing (i.e. mod+N to go to a
 - workspace, or mod+shift+N to move a window to a workspace).  The first line
 - constructs a list of 2-tuples, where the first element is a 2-tuple
 - containing a modifier mask (in this case either Mod or Shift+Mod) and the
 - actual target key, and the second element is the action.  The action is the
 - application of a function to the current window list.
 -
 - The list is built up via a complicated list comprehension.  Basically, first
 - pair up the 22 workspaces numbers with the keys we want to use for absolute
 - workspace selection (1-9, 0, F1-F12).  Insert those keys into the second
 - element of the key-description 2-tuple.  Then if there is the only modifier
 - is modmask, execute W.greedyView, which brings that workspace to the front.
 - Or, if the modifier is modmask + shiftMask, then execute W.shift, which moves
 - the current focused window to the target workspace.
 -}
switchWs = [((m .|. modmask, k), windows $ f i)
           | (i, k) <- zip myWorkspaces ([xK_1 .. xK_9] ++ [xK_0] ++ [xK_F1 .. xK_F12])
           , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Only useful for multiple-monitor setups.
 ++
           [((m .|. modmask, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_e, xK_w] [0..]
           , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 ++
           [((modmask .|. controlMask, key), warpToScreen sc (1%2) (1%2))
           | (key, sc) <- zip [xK_e, xK_w] [0..]]

myConfig xmproc = def {
        manageHook = manageDocks <+> myManageHook <+> manageHook def,
        layoutHook = avoidStruts myLayout,
        startupHook = setWMName "LG3D",
        workspaces = myWorkspaces,
        modMask = modmask,
        logHook = workspaceNamesPP xmobarPP {
            ppOutput = hPutStrLn xmproc
        } >>= dynamicLogWithPP
    } `additionalKeysP` [
        ("M-<Left>", prevWS ),
        ("M-<Right>", nextWS ),
        ("M-S-<Left>", shiftToPrev ),
        ("M-o", spawn "spectacle" ),
        ("M-S-o", spawn "flameshot gui" ),
        ("M-S-<Right>", shiftToNext ),
        ("M-S-l", spawn "xscreensaver-command -lock" ),
        ("M-a", spawn "arandr"),
        ("M-S-g", renameWorkspace def),

        ("M-C-S-u", spawn "pavucontrol"),

        ("<XF86Calculator>", spawn "gnome-calculator"),

        ("M-S-v", spawn "pkill -9 Discord"),

        ("M-C-z", warpToWindow (1%2) (1%2)),

        -- Inserts a UTC HH:MM:SS
        ("M-]", liftIO (formatTime defaultTimeLocale "%H:%M:%S" `fmap` getCurrentTime) >>= pasteString),

        ("M-<Escape> 1", spawn "setxkbmap us"),
        ("M-<Escape> 2", spawn "setxkbmap de"),
        ("M-<Escape> 3", spawn "setxkbmap gb extd"),
        ("M-<Escape> 4", spawn "setxkbmap ru")
    ] `additionalKeys`
    switchWs

main = do
    spawn "nm-applet"
    spawn "pkill -9 flameshot; flameshot"
    spawn "pkill -9 pasystray; pasystray"
    spawn "pkill -9 qpwgraph; qpwgraph -m"
    spawn "pkill -9 trayer; trayer --edge top --align right --SetDockType true --expand false --width 15 --transparent true --tint 0x191970 --height 18 --monitor $(xrandr | grep ' connected' | head -n -1 | wc -l) &"
    spawn "xscreensaver -no-splash"
    spawn "blueman-applet"
    spawn "dunst"
    spawn "feh --bg-fill /home/werneta/Pictures/wp2343900.png"
    xmproc <- spawnPipe "/home/werneta/.cabal/bin/xmobar"

    xmonad $ docks $ myConfig xmproc
