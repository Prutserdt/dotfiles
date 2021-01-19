 ____             _                    _ _                  _
|  _ \ _ __ _   _| |_ ___  ___ _ __ __| | |_   _ __ ___  __| | _____  __
| |_) | '__| | | | __/ __|/ _ \ '__/ _` | __| | '__/ _ \/ _` |/ _ \ \/ /
|  __/| |  | |_| | |_\__ \  __/ | | (_| | |_  | | |  __/ (_| | (_) >  <
|_|   |_|   \__,_|\__|___/\___|_|  \__,_|\__| |_|  \___|\__,_|\___/_/\_\

Prutserdt qmk configuration of the redox/rev1 keyboard with 4 layers.
UNDER CONSTRUCTION! :-)

0: qwerty. Some dual keys are set: Lctrl-Lsuper-Lalt: a-s-d and 
   Ralt-Rsuper-Rctrl: k-l-;. 

1: numpad.

2: arrow keys (hjkl)and some additonal keys (calc,mute,vol,caps).

3: F-keys, back lighting keys and reset.

4: Mouse layer.

These tap interrupts and tapping term settings work for my usecase:
#define IGNORE_MOD_TAP_INTERRUPT
#define TAPPING_TERM 400

Check config.h for more information.
