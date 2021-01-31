/* Good on you for modifying your layout! if you don't have
 * time to read the QMK docs, a list of keycodes can be found at
 *
 * https://github.com/qmk/qmk_firmware/blob/master/docs/keycodes.md
 *
 *  NOTE: You can enter programming mode by holding the Rightmost-Lower 1.5u (Right Shift) and plugging Gergo in (or pressing the reset)
 *  There's also a template for adding new layers at the bottom of this file!
 *
 *  qmk compile -kb gergo -km Prutserdt 
 *  qmk flash -kb gergo -km Prutserdt 
 */

#include QMK_KEYBOARD_H

enum customKeycodes {
	URL  = 1
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[0] = LAYOUT(
    KC_TAB,     KC_Q,       KC_W,       KC_E,       KC_R,       KC_T,                                                       KC_Y,       KC_U,       KC_I,       KC_O,       KC_P,       KC_PIPE,
    KC_ESC,     KC_A,       KC_S,       KC_D,       KC_F,       KC_G,       KC_BTN2,                            KC_TRNS,    KC_H,       KC_J,       KC_K,       KC_L,       KC_SCLN,    KC_QUOT,
    KC_LSFT,    KC_Z,       KC_X,       KC_C,       KC_V,       KC_B,       KC_BTN1,    KC_BTN3,    KC_PGDN,    KC_BSPC,    KC_N,       KC_M,       KC_COMM,    KC_DOT,     KC_SLSH,    KC_MINS,
                                                    TT(1),      TT(2),      KC_BSPC,    KC_DEL,     KC_ENT,     KC_SPC,     RESET,         RESET
    ),

[1] = LAYOUT(
    KC_TRNS,    KC_EXLM,    KC_AT,      KC_LCBR,    KC_RCBR,    KC_PIPE,                                                    KC_TRNS,    KC_7,       KC_8,       KC_9,       KC_TRNS,    KC_MINS,
    KC_TRNS,    KC_HASH,    KC_DLR,     KC_LPRN,    KC_RPRN,    KC_GRV,     KC_TRNS,                            ______,     KC_PLUS,    KC_4,       KC_5,       KC_6,       KC_PERC,    KC_PPLS,
    KC_TRNS,    KC_PERC,    KC_CIRC,    KC_LBRC,    KC_RBRC,    KC_TILD,    KC_TRNS,    ______,     ______,     ______,     KC_AMPR,    KC_1,       KC_2,       KC_3,       KC_DOT,     KC_PEQL,
                                                    KC_TRNS,    KC_TRNS,    KC_SCLN,    KC_EQL,     KC_BTN1,    KC_BTN3,    KC_BTN2,    KC_0
    ),

[2] = LAYOUT(
    KC_TRNS,    KC_1, 	    KC_2,       KC_3,       KC_4,       KC_5,                                                       KC_6,       KC_7,       KC_8,       KC_9,       KC_0,       KC_TRNS,
    KC_TRNS,    KC_F1,      KC_F2,      KC_F3,      KC_F4,      KC_F5,      KC_F6,                              KC_TRNS,    KC_LEFT,    KC_DOWN,    KC_UP,      KC_RGHT,    KC_VOLD,    KC_VOLU,
    KC_TRNS,    KC_F7,      KC_F8,      KC_F9,      KC_F10,     KC_F11,     KC_F12,     KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_MS_L,    KC_MS_D,    KC_MS_U,    KC_MS_R,    KC_MPLY,    KC_MNXT,
                                                    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS
    ),
};

/* Keymap template
 *
 * ,-------------------------------------------.                         ,-------------------------------------------.
 * |        |      |      |      |      |      |                         |      |      |      |      |      |        |
 * |--------+------+------+------+------+------|------.           .------|------+------+------+------+------+--------|
 * |        |      |      |      |      |      |      |           |      |      |      |      |      |      |        |
 * |--------+------+------+------+------+------|------|           |------|------+------+------+------+------+--------|
 * |        |      |      |      |      |      |      |           |      |      |      |      |      |      |        |
 * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
 *                        .------.   .------.                                 .------.   .-----.
 *                        |      |   |      |                                 |      |   |     |
 *                        '------'   '------'                                 `------.   '-----'
 *                                        ,-------.       ,-------.
 *                                        |       |       |       |
 *                                 ,------|-------|       |-------|------.
 *                                 |      |       |       |       |      |
 *                                 |      |       |       |       |      |
 *                                 |      |       |       |       |      |
 *                                 `--------------'       `--------------'
[SYMB] = LAYOUT_gergo(
    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,                                             KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,                           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,         KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,         KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
    )
 */
