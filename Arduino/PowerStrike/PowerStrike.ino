int main() {
/* PowerStrike v0.03. Gemaakt om een enkele FSR druk sensor live output te geven op een LCD scherm.*/

#include <LiquidCrystal.h> //Import de LCD library
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); // Initialiseren vd LCD en gebruikte pins

#define PowerStrikepin A0 // Definieer welke Arduino pin wordt gebruikt voor uitlezen
#define contra 9          // Definieer de pin die het contrast van de LCD regelt
#define bri 10            // Definieer de pin die de brightness van het LCD scherm regelt

// Definieer de variabelen
int PowerStrikereading;   // Variabele voor opslag PowerStrike waarde
int maximum;              // Variabelel die de maximale kracht bijhoud

void setup() {
  Serial.begin(9600);     // Zet serial communicatie op 9600 baud:
  maximum=0;              // Zet het maximum op 0, dit kan alleen maar oplopen :-)
  // LCD instellingen
  lcd.begin(16, 2);         // Stelt in dat de LCD een 16x2 type is
  pinMode(contra, OUTPUT);  // Maak pin 9 als OUTPUT
  pinMode(bri, OUTPUT);     // Maak pin 10 als OUTPUT
  digitalWrite(contra, LOW);// Geeft geen power aan contrast pin. Nu zie je woorden. Best handig.
  analogWrite(bri, 255);    // Geeft volledige power aan screen brightness LED (255)
}

void loop() {
  PowerStrikereading = analogRead(PowerStrikepin); // Lees PowerStrike pin en save als variabele

  // Print output naar de serial monitor.
  Serial.print("Analoge waarde = ");  // Print de string "Analoge waarde = ".
  Serial.print(PowerStrikereading);   // Voer eraan toe de 'Live readout
  // We zetten de grenzen waarbij een nieuw drukniveau is bereikt.
  // Zeer wetenschappelijke omschrijvingen natuurlijk.
  if (PowerStrikereading < 10) {
    Serial.println(" - Chillin. No pressure bruh");
  } else if (PowerStrikereading < 200) {
    Serial.println(" - Weakling. Put some violence in your violence brother. ");
  } else if (PowerStrikereading < 500) {
    Serial.println(" - Light sparring");
  } else if (PowerStrikereading < 800) {
    Serial.println(" - Brawling");
  } else {
    Serial.println(" - Throwing the kitchen sink. Goodnight Irene!");
  }

  // Print output naar de LCD.
  // Uitlezen in bovenste regel, onderste regel geeft het maximum
  if (PowerStrikereading < maximum) {
    lcd.setCursor(0, 0);            // Bovenste regel
    lcd.print(PowerStrikereading);  // 'Live' output
    lcd.setCursor(0, 1);            // Onderste regel
    lcd.print(maximum);             // Maximum output
  } else {
    lcd.setCursor(0, 0);            // Bovenste regel
    lcd.print(PowerStrikereading);  // 'Live' output
    maximum=PowerStrikereading;     // Maximum gevonden dus overschrijven
    lcd.setCursor(0, 1);            // Onderste regel
    lcd.print(maximum);             // Maximum output
    lcd.print("max");
  }

  delay(500); // De delay van de loop wordt ingesteld, in milliseconden.

}
return 0;
}
