/* Free software, GNU General Public Licence, see http:.gnu.org/licences
 * This layout is experimental and not a finished product */

#include QMK_KEYBOARD_H

/* Make layers readable by naming them */
#define _QWERTY 0
#define _ARROWS 1
#define _SYMBOL 2
#define _FUNC 3
#define _MOUSE 4
#define _NUMPAD 5

/* Make name of complex key funtions smaller, otherwise keymap becomes very wide */
#define A_CTL  LCTL_T(KC_A)
#define S_GUI  LGUI_T(KC_S)
#define D_ALT  LALT_T(KC_D)
#define K_ALT  RALT_T(KC_K)
#define L_GUI  RGUI_T(KC_L)
#define SC_CTL RCTL_T(KC_SCLN)


/* Custom keycodes */
enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  ARROWS,
  SYMBOL,
  FUNC,
  MOUSE,
  NUMPAD,
  // These use process_record_user()
  WLTAB, // switch to left tab in browser
  xxx,   // NOTE: without this line and comma after numpad  WRTAB will not work
  WRTAB, // Swtitch to right tab in browser
  CTL_A, // ctrl A, missing in base layer, because A and CTL are the same button.
  CTL_W, // to close the current tab in browser
  CTL_T, // open new tab tab in browser
  CTL_Z, // easier access to ctrl-z
  };

/* Send custom strings */
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case WLTAB:
    if (record->event.pressed) {
        SEND_STRING(SS_LCTL(SS_TAP(X_PGUP)));
    }
    break;
  case WRTAB:
    if (record->event.pressed) {
        SEND_STRING(SS_LCTL(SS_TAP(X_PGDN)));
    }
    break;
  case CTL_A:
    if (record->event.pressed) {
        SEND_STRING(SS_LCTL("a"));
    }
    break;
  case CTL_W:
    if (record->event.pressed) {
        SEND_STRING(SS_LCTL("w"));
    }
    break;
  case CTL_T:
    if (record->event.pressed) {
        SEND_STRING(SS_LCTL("t"));
    }
    break;
  case CTL_Z:
    if (record->event.pressed) {
        SEND_STRING(SS_LCTL("z"));
    }
    break;
  }
  return true;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_QWERTY] = LAYOUT(
  /* QWERTY (qwerty layer, ctrl/gui/alt in homerow and dynamic macro recording/recording stop/play buttons)*/
     KC_GRV,   KC_1,     KC_2,     KC_3,     KC_4,     KC_5,                                                 KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     KC_MINS,
     KC_TAB,   KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,     KC_HOME,                          KC_PGUP,  KC_Y,     KC_U,     KC_I,     KC_O,     KC_P,     KC_EQL,
     KC_ESC,   A_CTL,    S_GUI,    D_ALT,    KC_F,     KC_G,     KC_END,                           KC_PGDN,  KC_H,     KC_J,     K_ALT,    L_GUI,    SC_CTL,   KC_QUOT,
     KC_LSFT,  KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,     KC_LBRC,  KC_RBRC,    KC_PSCR,    KC_BSLS,  KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,  KC_RSFT,
     DM_PLY1,  DM_PLY2,  TT(5),    TT(4),          TT(1),        KC_BSPC,  KC_DEL,     KC_ENT,     KC_SPC,         TT(2),        TT(3),    DM_RSTP,  DM_REC2,  DM_REC1
  ),

  [_ARROWS ] = LAYOUT(
  /* Arrow keys at hjkl
   * Capslock
   * Calculator, volume keys and high F keys
   * EC_NORM and EC_SWAP, will swap escape/capslock
   * WLTAB moves to the left tab in a browser, in Brave that is: CTRL- page up
   * WRTAB moeve to the right tab in a brower, in brave that is CTRL- page down
   * CTL_W, control W will close the tab in brave browser
     QK_REP repeats the last pressed key and QK_AREP performs the reverse (only for left, home, page up etc)
   */
     EC_NORM,  KC_F14,   KC_F15,   KC_F16,   KC_F17,   KC_F18,                                               KC_BRID,  KC_BRIU,  KC_CALC,  KC_MUTE,  KC_VOLD,  KC_VOLU,
     _______,  _______,  CTL_W,    _______,  KC_WREF,  CTL_T,    QK_REP,                           KC_MNXT,  WLTAB,    KC_WBAK,  KC_WFWD,  WRTAB,    _______,  _______,
     EC_SWAP,  CTL_A,    KC_WSTP,  _______,  _______,  _______,  QK_AREP,                          KC_MPRV,  KC_LEFT,  KC_DOWN,  KC_UP,    KC_RIGHT, _______,  _______,
     _______,  CTL_Z,    _______,  KC_CAPS,  _______,  _______,  _______,  _______,    _______,    _______,  _______,  _______,  _______,  _______,  _______,  _______,
     _______,  _______,  _______,  _______,        _______,      _______,  _______,    _______,    _______,        _______,      _______,  _______,  _______,  _______
  ),

  [_SYMBOL] = LAYOUT(
  /* SYMBOL (number keys in home row, symbols in qwerty row)*/
     _______,  _______,  _______,  _______,  _______,  _______,                                              _______,  _______,  _______,  _______,  _______,  _______,
     KC_TILD,  KC_EXLM,  KC_AT,    KC_HASH,  KC_DLR,   KC_PERC,  _______,                          _______,  KC_CIRC,  KC_AMPR,  KC_ASTR,  KC_LPRN,  KC_RPRN,  _______,
     _______,  KC_1,     KC_2,     KC_3,     KC_4,     KC_5,     _______,                          _______,  KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     _______,
     _______,  _______,  _______,  _______,  _______,  _______,  _______,   _______,   _______,    _______,  _______,  _______,  _______,  _______,  _______,  _______,
     _______,  _______,  _______,  _______,        _______,      _______,   _______,   _______,    _______,        _______,      _______,  _______,  _______,  _______
  ),

  [_FUNC] = LAYOUT(
  /* FUNC (Function keys, home/pgup/pgdn/end on hjkl and RGB) */
     _______,  KC_F1,    KC_F2,    KC_F3,    KC_F4,    KC_F5,                                                KC_F6,    KC_F7,    KC_F8,    KC_F9,    KC_F10,   _______,
     _______,  KC_F11,   KC_F12,   KC_F13,   KC_F14,   KC_F15,   RGB_SAD,                          _______,  KC_F16,   KC_F17,   KC_F18,   KC_F19,   KC_F20,   _______,
     RGB_M_R,  _______,  RGB_TOG,  RGB_MOD,  RGB_RMOD, RGB_M_B,  RGB_SAI,                          _______,  KC_HOME,  KC_PGDN,  KC_PGUP,  KC_END,   _______,  _______,
     RGB_HUD,  RGB_HUI,  RGB_VAI,  RGB_VAD,  RGB_SPD,  RGB_SPI,  _______,  _______,    _______,    _______,  _______,  _______,  _______,  _______,  _______,  _______,
     RGB_M_K,  RGB_M_SN, RGB_M_SW, RGB_M_X,        RGB_M_G,      RGB_M_T,  RGB_M_P,    _______,    _______,        _______,      _______,  _______,  _______,  _______
  ),

  [_MOUSE] = LAYOUT(
  /* MOUSE (Mouse navigation/scrolling/buttons/speed and emojis) */
     _______,  _______,  _______,  _______,  _______,  _______,                                              _______,  _______,  _______,  _______,  _______,  _______,
     _______,  _______,  _______,  _______,  _______,  _______,  KC_WH_U,                          KC_BTN5,  _______,  _______,  _______,  _______,  _______,  _______,
     _______,  _______,  _______,  _______,  _______,  _______,  KC_WH_D,                          KC_BTN4,  KC_MS_L,  KC_MS_D,  KC_MS_U,  KC_MS_R,  _______,  _______,
     _______,  _______,  _______,  _______,  _______,  KC_ACL0,  KC_ACL1,  KC_ACL2,    _______,    _______,  _______,  _______,  _______,  _______,  _______,  _______,
     _______,  _______,  _______,  _______,        _______,      _______,  _______,    KC_BTN1,    KC_BTN2,        KC_BTN3,      _______,  _______,  _______,  _______
  ),

  [_NUMPAD] = LAYOUT(
  /* NUMPAD (Numpad and some rarely used keys) */
     _______,  _______,  _______,  _______,  _______,  _______,                                              _______,  _______,  _______,  _______,  _______,  _______,
     _______,  KC_APP,   _______,  KC_PAUS,  KC_INS,   _______,  _______,                          _______,  _______,  KC_7,     KC_8,     KC_9,     _______, _______,
     _______,  _______,  _______,  _______,  _______,  _______,  _______,                          _______,  _______,  KC_4,     KC_5,     KC_6,     _______,  _______,
     _______,  _______,  _______,  _______,  _______,  _______,  _______,  _______,    _______,    _______,  _______,  KC_1,     KC_2,     KC_3,     _______,  _______,
     _______,  _______,  _______,  _______,        _______,      _______,  _______,    _______,    _______,         _______,     KC_0,     KC_DOT,   _______,  _______
  )
};


void persistent_default_layer_set(uint16_t default_layer) {
    eeconfig_update_default_layer(default_layer);
    default_layer_set(default_layer);
}


/* Change LED colors depending on the layer. */
layer_state_t layer_state_set_user(layer_state_t state) {
  switch (get_highest_layer(state)) {
  case _QWERTY:
      rgblight_setrgb (0x66, 0x00, 0x33); /* Dark red */
      break;
  case _ARROWS:
      rgblight_setrgb (0x66, 0x00, 0x00); // red
      break;
  case _SYMBOL:
      rgblight_setrgb (0xFF, 0xD9, 0x00); // Gold
      break;
  case _FUNC:
      rgblight_setrgb (0x7A, 0x00, 0xFF); // Gold
      break;
  case _MOUSE:
      rgblight_setrgb (0xFF, 0xFF, 0x00); // Yellow
      break;
  case _NUMPAD:
      rgblight_setrgb (0xFF, 0x00, 0xFF); // magentac
      break;
  default: //  for any other layers, or the default layer
      rgblight_setrgb (0x66, 0x00, 0x33); /* Dark red */
      break;
  }
  return state;
};
