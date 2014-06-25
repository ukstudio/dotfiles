import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.GridSelect
import XMonad.Util.Run(spawnPipe)
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Layout.HintedGrid
import XMonad.Layout.Magnifier
import XMonad.Layout.IM
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Spacing
import XMonad.Util.NamedScratchpad

import Data.Monoid
import Data.Ratio ((%))
import System.IO
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--myTerminal = "gnome-terminal --hide-menubar"
-- myTerminal = "mate-terminal --hide-menubar"
myTerminal = "lxterminal"

scratchpads = [
    NS "htop" "gnome-terminal -t 'htop'" (title =? "htop") defaultFloating,
    NS "notes" "gvim --role notes ~/Documents/notes.txt" (role =? "notes") defaultFloating
    ] where role = stringProperty "WM_WINDOW_ROLE"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 1
myModMask       = mod1Mask
myNumlockMask   = mod2Mask
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "killall trayer-srg;killall xscreensaver; xmonad --recompile; xmonad --restart")
    -- run GridSelect
    , ((modm              , xK_g     ), goToSelected defaultGSConfig)
    -- run shell
    , ((modm              , xK_p     ), shellPrompt defaultXPConfig)
    -- run scratchpad
    , ((modm .|. controlMask, xK_t   ), namedScratchpadAction scratchpads "htop")
    , ((modm .|. controlMask, xK_n   ), namedScratchpadAction scratchpads "notes")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

basicLayout = spacing 2 $ Tall nmaster delta ratio
    where
        nmaster = 1
        ratio   = 1/2
        delta   = 3/100
tailLayout = named "tail" $ avoidStruts $ basicLayout
wideLayout = named "wide" $ avoidStruts $ Mirror basicLayout
fullLayout = named "full" $ avoidStruts $ Full
gridLayout = named "grid" $ avoidStruts $ magnifier (Grid False)
myLayout = tailLayout ||| wideLayout ||| gridLayout ||| fullLayout

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]

myEventHook = mempty
myLogHook proc = dynamicLogWithPP xmobarPP {
    ppOutput = hPutStrLn proc ,
    ppTitle  = xmobarColor "green" "" . shorten 50
    }
myStartupHook = return ()

main :: IO()
main = do
    spawn "trayer-srg --edge bottom --align right --SetDockType true --SetPartialStrut true --expand true --transparent true --tint 0x000000 --height 20"
    spawn "xmodmap /home/ukstudio/.Xmodmap"
    spawn "xscreensaver"
    -- spawn "uim-xim -d -x"
    spawn "xsetroot -cursor_name top_left_arrow"
    xmproc <- spawnPipe "xmobar /home/ukstudio/.xmobarrc -x 1"
    xmonad $ defaultConfig
        {
            terminal           = myTerminal,
            focusFollowsMouse  = myFocusFollowsMouse,
            borderWidth        = myBorderWidth,
            modMask            = myModMask,
            -- numlockMask        = myNumlockMask,
            workspaces         = myWorkspaces,
            normalBorderColor  = myNormalBorderColor,
            focusedBorderColor = myFocusedBorderColor,

            keys               = myKeys,
            mouseBindings      = myMouseBindings,

            layoutHook         = myLayout,
            manageHook         = manageDocks
                                 <+> myManageHook
                                 <+> namedScratchpadManageHook scratchpads,
            handleEventHook    = myEventHook,
            logHook            = myLogHook xmproc,
            startupHook        = myStartupHook
        }
