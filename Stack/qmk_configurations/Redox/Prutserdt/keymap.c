/* Free software, GNU General Public Licence, see http:.gnu.org/licences  */

#include QMK_KEYBOARD_H

/* Layer    Comments
 * 0        Base layer including dynamic macro record/play buttons
 * 1        hjkl as arrows, qwerty row as numbers plus some multimedia and application keys
 * 2        qwerty row for symbols (as shift numbers).
 * 3        Function keys and rgb layer
 * 4        Mouse layer and asci emojis (weird behaviour, see comments below)
 * 5        Numpad
 * This layout is experimental and not a finished product.
 *
 * TODO: couple a led colour/breathing to a layer, to make it more visual.
 *       Really quick red led blinking for macro recording for instance
 *       https://docs.qmk.fm/#/custom_quantum_functions?id=example-layer_state_set_-implementation
 */

/* Custom keycodes */
enum custom_keycodes {
  HAPPY,
  xxx, /* Weird bug. If this line is removed the next one will not work... */
  YOLO,
  SAD,
  };

/* Send custom strings */
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case HAPPY:
    if (record->event.pressed) {
        SEND_STRING(":-)");
    }
    break;
  case YOLO:
    if (record->event.pressed) {
        SEND_STRING(":-P");
    }
    break;
  case SAD:
    if (record->event.pressed) {
        SEND_STRING(":-(");
    }
    break;
  }
  return true;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [0] = LAYOUT(
     KC_GRV,        KC_1,           KC_2,           KC_3,           KC_4,           KC_5,                                                             KC_6,           KC_7,           KC_8,           KC_9,           KC_0,            KC_MINS,
     KC_TAB,        KC_Q,           KC_W,           KC_E,           KC_R,           KC_T,           KC_HOME,                          KC_PGUP,        KC_Y,           KC_U,           KC_I,           KC_O,           KC_P,            KC_EQL,
     KC_ESC,        LCTL_T(KC_A),   LGUI_T(KC_S),   LALT_T(KC_D),   KC_F,           KC_G,           KC_END,                           KC_PGDN,        KC_H,           KC_J,           RALT_T(KC_K),   RGUI_T(KC_L),   RCTL_T(KC_SCLN), KC_QUOT, 
     KC_LSFT,       KC_Z,           KC_X,           KC_C,           KC_V,           KC_B,           KC_LBRC,   KC_RBRC,   KC_PSCR,    KC_BSLS,        KC_N,           KC_M,           KC_COMM,        KC_DOT,         KC_SLSH,         KC_RSFT,
     DYN_MACRO_PLAY1,DYN_MACRO_PLAY2,TT(5),         TT(4),          TT(1),          KC_BSPC,        KC_DEL,                           KC_ENT,         KC_SPC,         TT(2),          TT(3),          DYN_REC_STOP,   DYN_REC_START2,  DYN_REC_START1 
  ),

  [1] = LAYOUT(
     _______,       _______,        _______,        _______,        _______,        _______,                                                          _______,        _______,        KC_CALC,        KC_MUTE,        KC_VOLD,         KC_VOLU, 
     _______,       KC_1,           KC_2,           KC_3,           KC_4,           KC_5,           _______,                          KC_MNXT,        KC_6,           KC_7,           KC_8,           KC_9,           KC_0,            _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          KC_MPRV,        KC_LEFT,        KC_DOWN,        KC_UP,          KC_RIGHT,       _______,         _______,
     _______,       _______,        _______,        KC_CAPS,        _______,        _______,        KC_LPRN,   KC_RPRN,    _______,   _______,        _______,        _______,        _______,        _______,        _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          _______,        _______,        _______,        _______,        _______,        _______,         _______
  ),

  [2] = LAYOUT(
     _______,       _______,        _______,        _______,        _______,        _______,                                                          _______,        _______,        _______,        _______,        _______,         _______, 
     KC_TILD,       KC_EXLM,        KC_AT,          KC_HASH,        KC_DLR,         KC_PERC,        _______,                          _______,        KC_CIRC,        KC_AMPR,        KC_ASTR,        KC_LPRN,        KC_RPRN,         KC_PMNS,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          _______,        _______,        _______,        _______,        _______,        _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,   _______,    _______,   _______,        _______,        _______,        _______,        _______,        _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          _______,        _______,        _______,        _______,        _______,        _______,         _______
  ),

  [3] = LAYOUT(
     _______,       _______,        _______,        _______,        _______,        _______,                                                          _______,        _______,        _______,        _______,        _______,         _______,
     _______,       KC_F1,          KC_F2,          KC_F3,          KC_F4,          KC_F5,          RGB_SAD,                          RGB_VAI,        KC_F6,          KC_F7,          KC_F8,          KC_F9,          KC_F10,          _______,
     _______,       RESET,          _______,        _______,        _______,        _______,        RGB_SAI,                          RGB_VAD,        _______,        RGB_HUD,        RGB_HUI,        _______,        _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,   _______,    _______,   _______,        _______,        RGB_SPD,        RGB_SPI,        _______,        _______,         _______,
     RGB_M_K,       RGB_M_SN,       RGB_M_SW,       RGB_M_X,        RGB_M_G,        RGB_M_T,        RGB_M_P,                          RGB_TOG,        RGB_MOD,        RGB_RMOD,       _______,        RGB_M_B,        RGB_M_B,         _______
  ),

  [4] = LAYOUT(
     _______,       _______,        _______,        _______,        _______,        _______,                                                          _______,        _______,        _______,        _______,        _______,         _______, 
     _______,       _______,        _______,        _______,        _______,        _______,        KC_WH_U,                          KC_BTN5,        _______,        _______,        YOLO,           SAD,            HAPPY,           _______,
     _______,       _______,        _______,        _______,        _______,        _______,        KC_WH_D,                          KC_BTN4,        KC_MS_L,        KC_MS_D,        KC_MS_U,        KC_MS_R,        _______,         _______,
     _______,       _______,        _______,        _______,        _______,        KC_ACL0,        KC_ACL1,   KC_ACL2,    _______,   _______,        _______,        _______,        _______,        _______,        _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          KC_BTN1,        KC_BTN2,        KC_BTN3,        _______,        _______,        _______,         _______
  ),

  [5] = LAYOUT(
     _______,       _______,        _______,        _______,        _______,        _______,                                                          _______,        _______,        _______,        _______,        _______,         _______, 
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          _______,        _______,        KC_7,           KC_8,           KC_9,           _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          _______,        _______,        KC_4,           KC_5,           KC_6,           _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,   _______,    _______,   _______,        _______,        KC_1,           KC_2,           KC_3,           _______,         _______,
     _______,       _______,        _______,        _______,        _______,        _______,        _______,                          _______,        _______,        _______,        _______,        KC_DOT,         _______,         _______
  )

};
