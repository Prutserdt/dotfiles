/* Copyright 2024 Prutserdt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

// Not yet available in `keymap.json` format
#ifdef RGB_MATRIX_ENABLE
#    define RGB_DISABLE_WHEN_USB_SUSPENDED
#    define RGB_MATRIX_KEYPRESSES
#    define ENABLE_RGB_MATRIX_SOLID_REACTIVE_SIMPLE
#    define ENABLE_RGB_MATRIX_SOLID_SPLASH
#    define ENABLE_RGB_MATRIX_RAINBOW_BEACON 
#endif

// Not yet available in `keymap.json` format
#ifdef MOUSEKEY_ENABLE
     // The default is 100
#    define MOUSEKEY_WHEEL_INTERVAL 50
     // The default is 40
#    define MOUSEKEY_WHEEL_TIME_TO_MAX 100
#endif

/* Longer holdtime for my CTL/GUI/ALT modkeys, otherwise it screws up typing 
 * A/S/D/K/L/: (see keymap.c for details)
 * The default tapping term is set to 200 ms, changed to 400 ms and later to 300 ms.
 */
#define TAPPING_TERM 300
//#define IGNORE_MOD_TAP_INTERRUPT //not needed in recent version of qmk, 2024

#define PERMISSIVE_HOLD_PER_KEY // added for my shift keys

/* Four taps are needed to switch on/of a layer. 
 * Two and tree taps led to a lot of annoying unintentional layer switching 
 */
#define TAPPING_TOGGLE 4

#define COMBO_TERM 50
#define EXTRA_SHORT_COMBOS

//#define SPLIT_USB_DETECT // Add this line to REV1/config.h or uncomment here!
