import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

myTerminal      = "konsole"
myBorderWidth   = 3
myModMask       = mod4Mask
myWorkspaces    = [ "1", "2", "3", "4", "5" ]
myFocusedBorderColor = "#0000ff"
myStartupHook :: X ()
myStartupHook = do
    spawn "setxkbmap de"
    spawn "feh --bg-fill ~/wallpaper.jpg"
    spawnOn "1" "yakuake"
    spawnOn "1" "firefox"
    spawnOn "1" "konsole"
    spawnOn "2" "dolphin"
    spawnOn "3" "thunderbird"
myManageHook :: [ManageHook]
myManageHook =
    [ className =? "Yakuake" --> doFloat
    , className =? "Pidgin" --> doFloat
    ]
myKeyBindings =
-- Move mod-h/j/k/l bindings to mod-j/k/l/ö
    [ ((myModMask, xK_j        ), sendMessage Shrink )
    , ((myModMask, xK_k        ), windows W.focusDown)
    , ((myModMask, xK_l        ), windows W.focusUp  )
    , ((myModMask, 0xf6        ), sendMessage Expand )
    , ((myModMask .|. shiftMask, xK_k        ), windows W.swapDown )
    , ((myModMask .|. shiftMask, xK_l        ), windows W.swapUp )
-- Use KDE's KSnapshot for screenshots
    , ((0        , xK_Print), spawn "ksnapshot")
    ]

-- defaults are defined in xmonad/XMonad/Config.hs
main = xmonad $ defaultConfig {
    terminal             = myTerminal
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    , startupHook        = myStartupHook
    , manageHook         = manageHook defaultConfig
                            <+> composeAll myManageHook
                            <+> manageDocks
                            <+> manageSpawn
    }
    `additionalKeys` myKeyBindings
