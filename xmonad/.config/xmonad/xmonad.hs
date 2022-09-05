import XMonad

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab

_terminal = "alacritty"

main :: IO()
main = xmonad $ def
    {
        modMask = mod4Mask -- Rebind Mod to Super
    }
    `additionalKeysP`
    [
        ("M-f", spawn "firefox-nightly"),
        ("M-a", spawn _terminal),
        ("M-d", spawn "rofi -show run")
    ]
