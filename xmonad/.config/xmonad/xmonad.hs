import XMonad

import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.Ungrab
import Xmonad.Hooks.DynamicLog
import Xmonad.Hooks.StatusBar
import Xmonad.Hooks.StatusBar.PP
import XMonad.Layout.ThreeColumns

_terminal = "alacritty"
main :: IO()
main = xmonad $ def
    {
        terminal = _terminal,
        modMask = mod4Mask -- Rebind Mod to Super
    }
    `additionalKeysP`
    [
        ("M-f", spawn "firefox-nightly"),
        ("M-<Return>", spawn _terminal),
        ("M-d", spawn "rofi -show run")

    ]
    `removeKeysP`
    [
        ("M-<Shift>-<Return>")
    ]

--_layout = tiled ||| Mirror tiled ||| Full
--    where
--        tiled = Tall nmaster delta ratio
--        nmaster = 1
--        ratio = 1/2
--        delta = 3/100
