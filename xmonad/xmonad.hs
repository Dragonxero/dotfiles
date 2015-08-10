-- $HOME/.xmonad/xmonad.hs
-- ghc --make xmonad.hs or xmonad --recomile
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Actions.GridSelect
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders (smartBorders)


myNormalBorderColor = "#010d11"
myFocusedBorderColor = "#6F00FF"
myCurrentWSColor = "#00FF7F"

myManageHook = composeAll
        [ (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
        , className =? "luakit" --> doShift "2:β"
        , className =? "luakit" --> doFloat
        , className =? "libreoffice-startcenter" --> doShift "4:δ"
        , className =? "libreoffice-startcenter" --> doFloat
        , className =? "firefox" --> doShift "1:α"
        , manageDocks
        ]
 
myLayout = Mirror tiled ||| tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 3/4
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100
 
--fades inactive windows, but is a bit distracting
--myLogHook :: X ()
--myLogHook = fadeInactiveLogHook fadeAmount
--    where fadeAmount = 0.8
 
main = do
        xmproc <- spawnPipe "xmobar ~/.xmobarrctop"
        xmbottom <- spawnPipe "xmobar ~/.xmobarrcbottom"
        xmonad $ defaultConfig
                { manageHook = fullscreenManageHook <+> myManageHook <+> manageHook defaultConfig
                , handleEventHook = fullscreenEventHook
 
                -- add --depth 32 for transparency, you need xcompmgr for shadows and transparency effects
                , terminal = "urxvt -bg rgba:0000/0000/0000/eeee -fg rgba:cc00/cc00/cc00/ffff +vb +sb"
 
                -- spawn programs you want at startup
                , startupHook = do
                                spawn "urxvt"
                                spawn "luakit"
 
                -- set your layout, smartborders removes window borders if not necessary
                , layoutHook = fullscreenFull $ avoidStruts $ smartBorders myLayout
 
                -- names and sequence of your workspaces
                , workspaces = ["1:α", "2:β", "3:γ", "4:δ", "5:ε", "6:ζ", "7:η", "8:θ", "9:ι", "0:κ"]
 
                -- sets the windows key as mod key, mod1Mask for alt
                , modMask = mod4Mask
 
                -- pipe title information into top bar of xmobar
                , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#1034A6" "" . shorten 30
                        , ppCurrent = xmobarColor myCurrentWSColor ""
                        }
                -- set your border colors
                , normalBorderColor = myNormalBorderColor
                , focusedBorderColor = myFocusedBorderColor
                }`additionalKeys`
                [ -- use Ctrl + Alt + L to lock the screen
                 -- ((mod1Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command --lock")
                 --  use Ctrl + Print to make a delayed screenshot
                  ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
                 -- use Print to make a screenshot
                , ((0, xK_Print), spawn "scrot")
                 -- Mod + g for gridselection for your workspaces
                , ((mod1Mask, xK_g), goToSelected defaultGSConfig)
                ]
--  vim: set ft=haskell ts=2 sw=2 fenc=utf-8:
