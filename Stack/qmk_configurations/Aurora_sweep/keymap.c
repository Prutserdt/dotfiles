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

#include QMK_KEYBOARD_H


/* Make layers readable by naming them */
#define _QWERTY 0
#define _ARROWS 1
#define _MOUSE  2
#define _FUNC 3
#define _NMBRS 4

/* Left-hand home row mods */
#define SFT_A LSFT_T(KC_A)
#define CTL_S LCTL_T(KC_S)
#define GUI_D LGUI_T(KC_D)
#define ALT_F LALT_T(KC_F)

/* Right-hand home row mods */
#define ALT_J RALT_T(KC_J)
#define GUI_K RGUI_T(KC_K)
#define CTL_L RCTL_T(KC_L)
#define SFT_SCLN RSFT_T(KC_SCLN)

/* Layer switching. NOTE: the mouse layer is accessed by a combo.*/
#define BSPC_1 LT(1,KC_BSPC)
#define DEL_2 LT(2,KC_DEL)
#define ENT_3 LT(3,KC_ENT)
#define SPC_4 LT(4,KC_SPC)

/* Custom keycodes */
enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  ARROWS,
  FUNC,
  NMBRS,
  MOUSE,
  FirmV,
  DD,
  YANK,
  PUKE,
  };

/* Send custom strings */
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case FirmV:
    if (record->event.pressed) {
        SEND_STRING("Prutserdt firmware v0.980");
    }
    break;
  case DD:
    if (record->event.pressed) {
        SEND_STRING(SS_TAP(X_HOME) SS_LSFT(SS_TAP(X_END)) SS_DELAY(200) SS_LCTL("x"));
    }
    break;
  case YANK:
    if (record->event.pressed) {
        SEND_STRING(SS_TAP(X_HOME) SS_LSFT(SS_TAP(X_END)) SS_LCTL("c") SS_DELAY(200) SS_TAP(X_HOME)); /* FIXME: would like to return to original at point */
    }
    break;
  case PUKE:
    if (record->event.pressed) {
        SEND_STRING(SS_TAP(X_END) SS_TAP(X_ENT) SS_LCTL("v") SS_TAP(X_HOME)  ); /* Evil mode: paste in line below */
    }
    break;
  }
  return true;
}

/* Use combos. Do not forget to add to rules.mk: COMBO_ENABLE = yes */
enum combos {
  /* Horizontal combos, only keys that are next to eachother */
  QW_REC1,    WE_REC2,    /*ER,*/    /*RT*/             /*YU,*/      /*UI,*/     IO_LBRC,    OP_RBRC,
  AS_STOP,    /*SD,*/     DF_ESC,    FG_TAB,            HJ_HOME,     JK_PGDN,    KL_PGUP,    LSCLN_END,
  ZX_PLAY1,   XC_PLAY2,   /*CV,*/    VB_CAPS,           /*NM*/       /*MCOMM,*/  /*COMDOT,*/ /*,*/
                                  BSPCDEL_RBT,         /*ENTSPC_LAY6,*/

  /* Vertical combos, only keys above/under eachother */
  /*QA,*/    /*WS,*/    ED_DD,    RF_COPY,   TG_UNDO,        YH_YANK,    /*UJ,*/    /*IK,*/    /*OL,*/    PSCLN_PUKE,
  /*AZ,*/    /*SX,*/    DC_CUT,   FV_PSTE,   GB_REDO,        /*HN,*/     /*JM,*/    /*K<,*/    /*L>,*/    /*:?,*/

};

/* Horizontal  combos                     key 1          key2 */
const uint16_t PROGMEM cv_combo[]       = {KC_C,         KC_V,            COMBO_END};
const uint16_t PROGMEM kl_combo[]       = {RGUI_T(KC_K), RCTL_T(KC_L),    COMBO_END};
const uint16_t PROGMEM hj_combo[]       = {KC_H,         RALT_T(KC_J),    COMBO_END};
const uint16_t PROGMEM jk_combo[]       = {RALT_T(KC_J), RGUI_T(KC_K),    COMBO_END};
const uint16_t PROGMEM vb_combo[]       = {KC_V,         KC_B,            COMBO_END};
const uint16_t PROGMEM df_combo[]       = {LGUI_T(KC_D), LALT_T(KC_F),    COMBO_END};
const uint16_t PROGMEM ui_combo[]       = {KC_U,         KC_I,            COMBO_END};
const uint16_t PROGMEM io_combo[]       = {KC_I,         KC_O,            COMBO_END};
const uint16_t PROGMEM op_combo[]       = {KC_O,         KC_P,            COMBO_END};
const uint16_t PROGMEM fg_combo[]       = {LALT_T(KC_F), KC_G,            COMBO_END};
const uint16_t PROGMEM lscln_combo[]    = {RCTL_T(KC_L), RSFT_T(KC_SCLN), COMBO_END};
const uint16_t PROGMEM bspcdel_combo[]  = {BSPC_1,       DEL_2,           COMBO_END};
const uint16_t PROGMEM qw_combo[]       = {KC_Q,         KC_W,            COMBO_END};
const uint16_t PROGMEM we_combo[]       = {KC_W,         KC_E,            COMBO_END};
const uint16_t PROGMEM as_combo[]       = {LSFT_T(KC_A), LCTL_T(KC_S),    COMBO_END};
const uint16_t PROGMEM zx_combo[]       = {KC_Z,         KC_X,            COMBO_END};
const uint16_t PROGMEM xc_combo[]       = {KC_X,         KC_C,            COMBO_END};

/* Vertical  combos                       key 1          key2 */
const uint16_t PROGMEM rf_combo[]       = {KC_R,         LALT_T(KC_F),    COMBO_END};
const uint16_t PROGMEM fv_combo[]       = {LALT_T(KC_F), KC_V,            COMBO_END};
const uint16_t PROGMEM tg_combo[]       = {KC_T,         KC_G,            COMBO_END};
const uint16_t PROGMEM gb_combo[]       = {KC_G,         KC_B,            COMBO_END};
const uint16_t PROGMEM ed_combo[]       = {KC_E,         LGUI_T(KC_D),    COMBO_END};
const uint16_t PROGMEM dc_combo[]       = {LGUI_T(KC_D), KC_C,            COMBO_END};
const uint16_t PROGMEM yh_combo[]       = {KC_Y,         KC_H,            COMBO_END};
const uint16_t PROGMEM pscln_combo[]    = {KC_P,         RSFT_T(KC_SCLN), COMBO_END};

/* Other  combos                          key 1          key2 */
const uint16_t PROGMEM wa_combo[]       = {KC_W,         LSFT_T(KC_A),    COMBO_END};
const uint16_t PROGMEM el_combo[]       = {KC_E,         RCTL_T(KC_L),    COMBO_END};
const uint16_t PROGMEM wal_combo[]      = {KC_W,         LSFT_T(KC_A),  RCTL_T(KC_L),    COMBO_END};

combo_t key_combos[] = {
  /* Horizontal combos */
  [DF_ESC]       = COMBO(df_combo,       KC_ESC),
  [FG_TAB]       = COMBO(fg_combo,       KC_TAB),
  [VB_CAPS]      = COMBO(vb_combo,       KC_CAPS),
  [LSCLN_END]    = COMBO(lscln_combo,    KC_END),
  [HJ_HOME]      = COMBO(hj_combo,       KC_HOME),
  [JK_PGDN]      = COMBO(jk_combo,       KC_PGDN),
  [KL_PGUP]      = COMBO(kl_combo,       KC_PGUP),
  [IO_LBRC]      = COMBO(io_combo,       KC_LBRC),
  [OP_RBRC]      = COMBO(op_combo,       KC_RBRC),
  [QW_REC1]      = COMBO(qw_combo,       DM_REC1),
  [WE_REC2]      = COMBO(we_combo,       DM_REC2),
  [AS_STOP]      = COMBO(as_combo,       DM_RSTP),
  [ZX_PLAY1]     = COMBO(zx_combo,       DM_PLY1),
  [XC_PLAY2]     = COMBO(xc_combo,       DM_PLY2),
  [BSPCDEL_RBT]  = COMBO(bspcdel_combo,  QK_RBT),

  /* Vertical combos */
  [ED_DD]        = COMBO(ed_combo,       DD),
  [YH_YANK]      = COMBO(yh_combo,       YANK),
  [DC_CUT]       = COMBO(dc_combo,       C(KC_X)),
  [RF_COPY]      = COMBO(rf_combo,       C(KC_C)),
  [FV_PSTE]      = COMBO(fv_combo,       C(KC_V)),
  [PSCLN_PUKE]   = COMBO(pscln_combo,    PUKE),
  [TG_UNDO]      = COMBO(tg_combo,       C(KC_Z)),
  [GB_REDO]      = COMBO(gb_combo,       C(KC_Y)),
};

bool get_permissive_hold(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case LSFT_T(KC_A):
      /* Immediately select the hold action when another key is tapped. */
      return true;
    default:
      /* Do not select the hold action when another key is tapped. */
      return false;
  }
  switch (keycode) {
    case RSFT_T(KC_SCLN):
      /* Immediately select the hold action when another key is tapped. */
      return true;
    default:
      /* Do not select the hold action when another key is tapped. */
      return false;
  }
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_QWERTY] = LAYOUT(
  /* 0: QWERTY (qwerty layer, shft/ctrl/gui/alt in home row) */
    KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,       KC_Y,     KC_U,     KC_I,     KC_O,     KC_P,
    SFT_A,    CTL_S,    GUI_D,    ALT_F,    KC_G,       KC_H,     ALT_J,    GUI_K,    CTL_L,    SFT_SCLN,
    KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,       KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,
                                  BSPC_1,   DEL_2,      ENT_3,    SPC_4
  ),

  [_ARROWS ] = LAYOUT(
  /* 1: ARROWS (arrow keys at hjkl, capslock, Firmware info  and some media keys. The Function keys are used in my QTILE configuration) */
    KC_F16,   KC_F17,   KC_F18,   KC_BRID,  KC_BRIU,    KC_PSCR,  KC_CALC,  KC_MUTE,  KC_VOLD,  KC_VOLU,
    _______,  _______,  _______,  _______,  _______,    KC_LEFT,  KC_DOWN,  KC_UP,    KC_RIGHT, _______,
    _______,  _______,  KC_CAPS,  FirmV,    _______,    _______,  _______,  _______,  _______,  KC_INS,
                                  _______,  _______,    _______,  _______
  ),


  [_MOUSE] = LAYOUT(
  /* 2: MOUSE (Mouse navigation/scrolling/buttons/speed) */
    _______,  _______,  _______,  _______,  KC_ACL0,    KC_WH_L,  KC_WH_D,  KC_WH_U,  KC_WH_R,  _______,
    _______,  _______,  _______,  _______,  KC_ACL1,    KC_MS_L,  KC_MS_D,  KC_MS_U,  KC_MS_R,  _______,
    KC_BTN6,  KC_BTN7,  KC_BTN8,  _______,  KC_ACL2,    KC_BTN1,  KC_BTN2,  KC_BTN3,  KC_BTN4,  KC_BTN5,
                                  _______,  _______,    _______,  _______
  ),

  [_FUNC] = LAYOUT(
  /* 3: FUNC (Function keys) */
    KC_F1,    KC_F2,    KC_F3,    KC_F4,    KC_F5,      KC_F6,    KC_F7,    KC_F8,    KC_F9,    KC_F10,
    KC_F11,   KC_F12,   KC_F13,   KC_F14,   KC_F15,     KC_F16,   KC_F17,   KC_F18,   KC_F19,   KC_F20,
    KC_F21,   KC_F22,   KC_F23,   KC_F24,   _______,    _______,  _______,  _______,  _______,  _______,
                                  _______,  _______,    _______,  _______
  ),

  [_NMBRS] = LAYOUT(
  /* 4: NMBRS (number keys in home row, symbols in qwerty row plus missing symbols) */
    KC_EXLM,  KC_AT,    KC_HASH,  KC_DLR,   KC_PERC,    KC_CIRC,  KC_AMPR,  KC_ASTR,  KC_LPRN,  KC_RPRN,
    KC_1,     KC_2,     KC_3,     KC_4,     KC_5,       KC_6,     KC_7,     KC_8,     KC_9,     KC_0,
    KC_GRV,   KC_BSLS,  KC_QUOT,  KC_EQL,   KC_MINS,    _______,  _______,  _______,  _______,  _______,
                                  _______,  _______,    _______,  _______
  )
};
