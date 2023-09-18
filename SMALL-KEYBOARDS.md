# Additional Configuration for Small Keyboards

## 1. Swap ESC key and the tile key with `swap_esc_tlde.diff` ###

For keyboards with a limited number of keys (63 keys), where the upper-left key is often assigned to ESC instead of tilde, you may prefer to have the tilde key for its use in vim and command line operations. To change the ESC key to a tilde, add the following to the section "English (intl., with AltGr dead keys)":

```bash
key <ESC> { [    grave, asciitilde,  dead_grave,   dead_tilde, Escape ] };
```

This layout is designed to enhance the typing experience for users frequently working with mathematical symbols and expressions. Your feedback and suggestions for improvement are always welcome.

## 2. Use the CAPS key as ISO_Level5_Shift with `swap_caps_level5_shift.diff`

In this project, we remapped LWIN key (Left Windows) to ISO_Level5_Shift. If your keyboard lacks a WIN key,  you can repurpose the CAPS key to serve as `ISO_Level5_Shift` using a feature called tap-hold pattern, which means a key function differently when it is tapped then when it is held in combination of another key. You can do so through 2 simple steps, 

1. **Remap the CAPS Key**: Add the following to `/usr/share/X11/xkb/symbols/us`:
   ```
   // Map CAPS to ISO_Level5_Shift and let someone else play Caps_Lock
   key <CAPS> { [ ISO_Level5_Shift ] };
   key <RWIN> { [ Caps_Lock ] };
   ```

2. **Restore Caps_Lock Function**: Execute the command:
   
   ```
   xcape -e 'ISO_Level5_Shift=Caps_Lock' -t 100
   ```
   in your session manager to revert the `Caps_Lock` function to the CAPS key. You might want to play with the timeout value to find the best number for you.
   

**Special Case: Retaining `SUPER_L` Function**
If you have a Windows key and wish to keep its `SUPER_L` function, remove or comment out the `include "level5(lwin_switch_lock)"` line from the keyboard layout configuration. This line repurposes the Windows key's function.

**Can this be done with a programmable keyboard?**
Instead of mapping LWIN as ISO_Level5_Shift, you might consider program a keyboard to use a special key to do it.

In the file `/usr/share/X11/xkb/keycodes/evdev` on many Linux distributions, you'll find the following mapping:

```   
<LVL5> =   203;
```

This means that keycode 203 corresponds to the LVL5 key in X11. Due to an established offset of +8 between X11 keycodes and Linux driver keycodes (historically set at this value), the actual keycode transmitted by the Linux driver for the LVL5 key would be 195 (`203 - 8`). 

However, I haven't personally tested this approach since I'm not familiar with keyboard firmware programming frameworks like QMK/VIA, and I suspect if it would work, since key 195 is not defined in `linux/include/uapi/linux/input-event-codes.h` at all. It appears no existing keyboard has LVL5 keys, or even if it does the Linux kernel may not recognize an event when it is pressed as USB HID keycode 195 is undefined.

If your keyboard firmware supports a tap-and-hold feature natively, you could program the CAPSLOCK key such that when held, it sends the Linux driver keycode 195. With luck, this may be interpreted by X11 as holding down the LVL5 key. 

