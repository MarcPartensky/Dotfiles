import XMonad

import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.Ungrab

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
