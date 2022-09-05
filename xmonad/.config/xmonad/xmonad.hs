import XMonad

import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.Ungrab
import XMonad.Actions.MouseGestures
-- import XMonad.Actions.ManageDocks
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myTerminal = "alacritty"

gestures = M.fromList
    [ ([], focus)
    , ([U], \w -> focus w >> windows W.swapUp)
    , ([D], \w -> focus w >> windows W.swapDown)
    , ([R, D], \_ -> sendMessage NextLayout)
    -- , ((modm .|. shiftMask, button3), mouseGesture gestures)
    -- , ((modm .|. shiftMask, button3), mouseGesture gestures)
    ]

myMouseBindings = [ ( ( 0, button1 ), mouseGesture gestures ) ]

main = xmonad $ def
    { terminal = myTerminal
    , modMask = mod4Mask -- Rebind Mod to Super
    }
    -- `additionalMouseBindings` myMouseBindings
    `additionalKeysP`
    [ ("M-f", spawn "firefox-nightly")
    , ("M-<Return>", spawn myTerminal)
    , ("M-d", spawn "rofi -show run")
    ]
    `removeKeysP`
    [ ("M-<Shift>-<Return>")
    ]
