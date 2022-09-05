import XMonad

-- import XMonad.Util.EZConfig (additionalKeysP)
-- import XMonad.Util.Ungrab

main :: IO()
main = xmonad $ def
    {
        modMask = mod4Mask -- Rebind Mod to Super
    }
