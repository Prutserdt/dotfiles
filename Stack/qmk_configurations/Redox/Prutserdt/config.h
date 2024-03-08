/* Modified by Prutserdt from the default config.h created by Mattia Dal Ben
 *
 * This program is free software: GNU General Public License version 2 as 
 * published by the Free Software Foundation.
 */

#pragma once

/* Longer holdtime for my CTL/GUI/ALT modkeys, otherwise it screws up typing 
 * A/S/D/K/L/: (see keymap.c for details)
 * The default tapping term is set to 200 ms, changed to 400 ms.
 */
#define TAPPING_TERM 400
//#define IGNORE_MOD_TAP_INTERRUPT //not needed in recent version of qmk, 2024

/* Four taps are needed to switch on/of a layer. 
 * Two and tree taps led to a lot of annoying unintentional layer switching 
 */
#define TAPPING_TOGGLE 4

/* Use I2C or Serial, not both */
#define USE_SERIAL
/* #define USE_I2C */

/* Select hand configuration */
#define MASTER_LEFT
/*  #define MASTER_RIGHT
 *  #define EE_HANDS
 */

#undef RGBLED_NUM
#define RGBLIGHT_ANIMATIONS //deprecated, should be changed
#define RGBLED_NUM 14
#define RGBLIGHT_HUE_STEP 8
#define RGBLIGHT_SAT_STEP 8
#define RGBLIGHT_VAL_STEP 8
