/* Free software, GNU General Public Licence, see http:.gnu.org/licences
 * This layout is experimental and not a finished product. Regards, Prutserdt */

#include QMK_KEYBOARD_H

/* Make layers readable by naming them */
#define _QWERTY 0
#define _ARROWS 1
#define _NMBRS 2
#define _FUNC 3
#define _MOUSE 4
#define _NUMPAD 5

/* Custom keycodes */
enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  ARROWS,
  NMBRS,
  FUNC,
  MOUSE,
  NUMPAD,
  FirmV
  };

/* Send custom strings */
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case FirmV:
    if (record->event.pressed) {
        SEND_STRING("Redox keyboard. Prutserdt firmware v0.92. More info: Prutserdt Github Redox.");
    }
    break;
  }
  return true;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_QWERTY] = LAYOUT(
  // 0: QWERTY (qwerty layer, ctrl/gui/alt in home row and dynamic macro recording/recording stop/play buttons)
  //┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐                                           ┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐
     KC_GRV,      KC_1,        KC_2,        KC_3,        KC_4,        KC_5,                                                    KC_6,        KC_7,        KC_8,        KC_9,        KC_0,        KC_MINS,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┐                       ┌─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     KC_TAB,      KC_Q,        KC_W,        KC_E,        KC_R,        KC_T,        KC_HOME,                          QK_AREP,  KC_Y,        KC_U,        KC_I,        KC_O,        KC_P,        KC_EQL,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┤                       ├─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     KC_ESC,      LCTL_T(KC_A),LGUI_T(KC_S),LALT_T(KC_D), KC_F,       KC_G,        KC_END,                           QK_REP,   KC_H,        KC_J,        RALT_T(KC_K), RGUI_T(KC_L), RCTL_T(KC_SCLN), KC_QUOT,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┼─────────┐ ┌───────────┼─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     SC_LSPO,     KC_Z,        KC_X,        KC_C,        KC_V,        KC_B,        KC_LBRC,  KC_RBRC,    KC_PSCR,    KC_BSLS,  KC_N,        KC_M,        KC_COMM,     KC_DOT,      KC_SLSH,     SC_RSPC,
  //├────────────┼────────────┼────────────┼────────────┼────────┬───┴────┬───────┼─────────┼─────────┤ ├───────────┼─────────┼────────┬───┴────┬───────┼────────────┼────────────┼────────────┼────────────┤
     DM_PLY1,     DM_PLY2,     TT(5),       TT(4),                TT(1),           KC_BSPC,  KC_DEL,     KC_ENT,     KC_SPC,            TT(2),           TT(3),       DM_RSTP,     DM_REC2,     DM_REC1
  //└────────────┴────────────┴────────────┴────────────┘        └────────┘       └─────────┴─────────┘ └───────────┴─────────┘        └────────┘       └────────────┴────────────┴────────────┴────────────┘
  ),

  [_ARROWS ] = LAYOUT(
  // 1: ARROWS (arrow keys at hjkl, capslock, Firmware info, RGB toggle  and some media keys. The Function keys are duplication of some F numbers, and used in my QTILE configuration)
  //┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐                                           ┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐
     KC_F13,      KC_F14,      KC_F15,      KC_F16,      KC_F17,      KC_F18,                                                  KC_BRID,     KC_BRIU,     KC_CALC,     KC_MUTE,     KC_VOLD,     KC_VOLU,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┐                       ┌─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     _______,                          _______,  _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┤                       ├─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     _______,                          _______,  KC_LEFT,     KC_DOWN,     KC_UP,       KC_RIGHT,    _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┼─────────┐ ┌───────────┼─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     KC_CAPS,     FirmV,       RGB_TOG,     _______,  _______,    _______,    _______,  _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────┬───┴────┬───────┼─────────┼─────────┤ ├───────────┼─────────┼────────┬───┴────┬───────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,              _______,         _______,  _______,    _______,    _______,           _______,         _______,     _______,     _______,     _______
  //└────────────┴────────────┴────────────┴────────────┘        └────────┘       └─────────┴─────────┘ └───────────┴─────────┘        └────────┘       └────────────┴────────────┴────────────┴────────────┘
  ),

  [_NMBRS] = LAYOUT(
  // 2: NMBRS (number keys in home row, symbols in qwerty row)
  //┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐                                           ┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐
     _______,     _______,     _______,     _______,     _______,     _______,                                                 _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┐                       ┌─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     KC_TILD,     KC_EXLM,     KC_AT,       KC_HASH,     KC_DLR,      KC_PERC,     _______,                          _______,  KC_CIRC,     KC_AMPR,     KC_ASTR,     KC_LPRN,     KC_RPRN,     KC_PMNS,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┤                       ├─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     KC_1,        KC_2,        KC_3,        KC_4,        KC_5,        _______,                          _______,  KC_6,        KC_7,        KC_8,        KC_9,        KC_0,        _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┼─────────┐ ┌───────────┼─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     _______,   _______,   _______,    _______,  _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────┬───┴────┬───────┼─────────┼─────────┤ ├───────────┼─────────┼────────┬───┴────┬───────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,              _______,         _______,   _______,   _______,    _______,           _______,         _______,     _______,     _______,     _______
  //└────────────┴────────────┴────────────┴────────────┘        └────────┘       └─────────┴─────────┘ └───────────┴─────────┘        └────────┘       └────────────┴────────────┴────────────┴────────────┘
  ),

  [_FUNC] = LAYOUT(
  // 3: FUNC (Function keys, home/pgup/pgdn/end on hjkl and RGB)
  //┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐                                           ┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐
     _______,     KC_F1,       KC_F2,       KC_F3,       KC_F4,       KC_F5,                                                   KC_F6,       KC_F7,       KC_F8,       KC_F9,       KC_F10,      _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┐                       ┌─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     KC_F11,      KC_F12,      KC_F13,      KC_F14,      KC_F15,      _______,                          _______,  KC_F16,      KC_F17,      KC_F18,      KC_F19,      KC_F20,      _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┤                       ├─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     KC_F21,      KC_F22,      KC_F23,      KC_F24,      _______,     _______,                          _______,  KC_HOME,     KC_PGDN,     KC_PGUP,     KC_END,      _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┼─────────┐ ┌───────────┼─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     _______,   _______,   _______,    _______,  _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────┬───┴────┬───────┼─────────┼─────────┤ ├───────────┼─────────┼────────┬───┴────┬───────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,              _______,         _______,   _______,   _______,    _______,           _______,         _______,     _______,     _______,     _______
  //└────────────┴────────────┴────────────┴────────────┘        └────────┘       └─────────┴─────────┘ └───────────┴─────────┘        └────────┘       └────────────┴────────────┴────────────┴────────────┘
  ),

  [_MOUSE] = LAYOUT(
  // 4: MOUSE (Mouse navigation/scrolling/buttons/speed)
  //┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐                                           ┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐
     _______,     _______,     _______,     _______,     _______,     _______,                                                 _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┐                       ┌─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     KC_WH_U,                          KC_BTN5,  _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┤                       ├─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     KC_WH_D,                          KC_BTN4,  KC_MS_L,     KC_MS_D,     KC_MS_U,     KC_MS_R,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┼─────────┐ ┌───────────┼─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     KC_ACL0,     KC_ACL1,  KC_ACL2,    _______,    _______,  _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────┬───┴────┬───────┼─────────┼─────────┤ ├───────────┼─────────┼────────┬───┴────┬───────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,              _______,         _______,  _______,    KC_BTN1,    KC_BTN2,           KC_BTN3,         _______,     _______,     _______,     _______
  //└────────────┴────────────┴────────────┴────────────┘        └────────┘       └─────────┴─────────┘ └───────────┴─────────┘        └────────┘       └────────────┴────────────┴────────────┴────────────┘
  ),

  [_NUMPAD] = LAYOUT(
  // 5: NUMPAD (Numpad)
  //┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐                                           ┌────────────┬────────────┬────────────┬────────────┬────────────┬────────────┐
     _______,     _______,     _______,     _______,     _______,     _______,                                                 _______,     _______,     _______,     _______,     _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┐                       ┌─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,      _______,    _______,     _______,     _______,     _______,                          _______,  _______,     KC_7,        KC_8,        KC_9,        _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┤                       ├─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     _______,                          _______,  _______,     KC_4,        KC_5,        KC_6,        _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────────┼────────────┼─────────┼─────────┐ ┌───────────┼─────────┼────────────┼────────────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,     _______,     _______,     _______,  _______,    _______,    _______,  _______,     KC_1,        KC_2,        KC_3,        _______,     _______,
  //├────────────┼────────────┼────────────┼────────────┼────────┬───┴────┬───────┼─────────┼─────────┤ ├───────────┼─────────┼─────────┬──┴─────┬──────┼────────────┼────────────┼────────────┼────────────┤
     _______,     _______,     _______,     _______,              _______,         _______,  _______,    _______,    _______,            _______,        KC_0,        KC_DOT,      _______,     _______
  //└────────────┴────────────┴────────────┴────────────┘        └────────┘       └─────────┴─────────┘ └───────────┴─────────┘         └────────┘      └────────────┴────────────┴────────────┴────────────┘
  )
};

/* Change LED colors depending on the layer. */
layer_state_t layer_state_set_user(layer_state_t state) {
    switch (get_highest_layer(state)) {
    case _QWERTY:
        rgblight_setrgb (0x66, 0x00, 0x00); /* Red */
        break;
    case _ARROWS:
        rgblight_setrgb (0x66, 0x00, 0x33); /* Pink */
        break;
    case _NMBRS:
        rgblight_setrgb (0xFF, 0xD9, 0x00); /* Yellow */
        break;
    case _FUNC:
        rgblight_setrgb (0x7A, 0x00, 0xFF); /* Purple */
        break;
    case _MOUSE:
        rgblight_setrgb (0xFF, 0xFF, 0x00); /* Yellow */
        break;
    case _NUMPAD:
        rgblight_setrgb (0xFF, 0x00, 0xFF); /* Magenta */
        break;
    default: /* For any other layers, or the default layer */
        rgblight_setrgb (0xFF, 0x00, 0x00); /* Red */
        break;
    }
  return state;
};
