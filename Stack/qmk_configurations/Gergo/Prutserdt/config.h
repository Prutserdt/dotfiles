// Modified by Prutserdt from the default config.h created by Mattia Dal Ben

// This program is free software: GNU General Public License version 2 as 
// published by the Free Software Foundation.

#pragma once

// Next line added by Prutserdt, not in original config.h
// Longer holdtime for modkey, otherwise screwups with home row mod keys.
// Default is 200 ms.
#define TAPPING_TERM 400
#define IGNORE_MOD_TAP_INTERRUPT

// Next line modified by Prutserdt. Switch to layer after three taps, instead of 
// the default of five taps.
// Two taps led to unintentional switching, which is annoying
// Threej taps led to unintentional switching, which is annoying
#define TAPPING_TOGGLE 4
// The rest of this config is untouched.

/* Use I2C or Serial, not both */
#define USE_SERIAL
// #define USE_I2C

/* Select hand configuration */
#define MASTER_LEFT
// #define MASTER_RIGHT
// #define EE_HANDS

#undef RGBLED_NUM
#define RGBLIGHT_ANIMATIONS
#define RGBLED_NUM 14
#define RGBLIGHT_HUE_STEP 8
#define RGBLIGHT_SAT_STEP 8
#define RGBLIGHT_VAL_STEP 8
