# Genshin Controls Improved

## Autohotkey script to improve Genshin Impact controls and automate some repetitive actions
Unlike other projects, this script intentionally not implemented more advanced features,
that requires to read pixels color, because of fragility of such approach
(very dependent on system, graphic settings, game version).
So, it should keep working for a long time across game updates.
Just configure it for your screen resolution (see below). **Note, only 16:9 displays are supported for now.**

## How to use
* Install [AutoHotkey](https://www.autohotkey.com/) 1.1 (not 2.0)
* Clone this repo or just download script file
* Run `genshin-controls-improved.ahk` **with administrator rights**

## Hotkeys
All hotkeys are active only when Genshin Impact window is focused.

- **Mouse forward button** = W (to run with mouse only, with one hand)
- **Mouse wheel left/right**: Clicks left/right arrows on screens, like Battle pass, Party setup, Characters screen
- **F13** (I bind extra mouse buttons to F13, F14 and so on with mouse software): Spams normal attack, while the key is pressed.
Extremely useful with characters like Yoimiya, Noelle
- **F14**: Select and use teleport on world map with single click.
Note, this only works, when selected teleport/domain is located apart other objects
- **Numpad 0**: Lock/Unlock in artifact view
- **Numpad 1**: Use it near Katheryne to claim daily reward for 4 comissions and resend expeditions with single key.
Assuming that "Auto-Play Story" setting set to "Off"
- **Crtl + Numpad 1**: Resend expeditions in expeditions screen. Use it instead previous hotkey, when you need only expeditions
- **Numpad 2**: Collect all BP experience
- **Numpad 3**: Collect all BP rewards. Use it right after previous hotkey, in case of BP level up
- **Numpad 4**: Deploy previous party with single key
- **Numpad 5**: Deploy next party with single key
- **Numpad 6**: Deploy "next after next" party (3, when 1 is selected, for example) with single key
- **F8**: Queue 4 x 5 Mystic Enhancement Ore crafts in forging screen. Select recipe before use
- **F9**: Buy maximum possible items. For example, seeds in Teapot
- **Alt + Numpad Dot**: Quit game (game menu -> quit -> confirm -> waiting for login screen -> quit -> confirm) and script

## Configuration / Modification
### Screen resolution
All screen coordinates are hardcoded, but you can configure script for your screen resulution (only 16:9 supported for now):

Find at the beginning: `global scaleFrom1080p := 1.333333`

Default value is for 2k (2560x1440). Change to `1.0` for 1080p (1920x1080) or `2.0` for 4k (3840x2160)

### Keybinds
All hotkey declarations are at the beginning. Feel free to change it on [your own](https://www.autohotkey.com/docs/v1/KeyList.htm).

### Expeditions
Defaults are:
* 2 ore expeditions in Mondstadt
* 1 meat expedition in Mondstadt
* 1 ore expedition in Liyue
* 1 mora expedition in Liyue

This can be changed in `initExpeditions()` function (edit map index + coordinates on the screen)
