/* PowerStrike v0.04. Twee FSR druk sensoren met live output op een LCD scherm en naar de serial monitor.*/

#include <LiquidCrystal.h>             //Import de LCD library
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); // Initialiseren vd LCD en gebruikte pins

#define PowerStrikepinA A0 // Definieer welke Arduino pin wordt gebruikt voor uitlezen
#define PowerStrikepinB A1 // Definieer welke Arduino pin wordt gebruikt voor uitlezen
#define contra 9           // Definieer de pin die het contrast van de LCD regelt
#define bri 10             // Definieer de pin die de brightness van het LCD scherm regelt

// Definieer de variabelen
int PowerStrikereadingA;   // Variabele voor opslag PowerStrike waarde
int maximumA;              // Variabelel die de maximale kracht bijhoud
int maximumB;              // Variabelel die de maximale kracht bijhoud
int PowerStrikereadingB;   // Variabele voor opslag PowerStrike waarde

void setup() {
  Serial.begin(9600);      // Zet serial communicatie op 9600 baud:
  maximumA=0;              // Zet het maximum op 0, dit kan alleen maar oplopen :-)
  maximumB=0;              // Zet het maximum op 0, dit kan alleen maar oplopen :-)
 
  // LCD instellingen
  lcd.begin(16, 2);         // Stelt in dat de LCD een 16x2 type is
  pinMode(contra, OUTPUT);  // Maak pin 9 als OUTPUT
  pinMode(bri, OUTPUT);     // Maak pin 10 als OUTPUT
  digitalWrite(contra, LOW);// Geeft geen power aan contrast pin. Nu zie je woorden. Best handig.
  analogWrite(bri, 255);    // Geeft volledige power aan screen brightness LED (255)

  // Stukje amusement op de LCD
  lcd.setCursor(0, 0);            // Bovenste regel
  lcd.print("**PowerStrike**");
  lcd.setCursor(0, 1);            // Onderste regel
  lcd.print("Booting in ");
  delay(500); // De delay van de loop wordt ingesteld, in milliseconden.
  lcd.setCursor(0, 1);            // Onderste regel
  lcd.print("Booting in 3");
  delay(500); // De delay van de loop wordt ingesteld, in milliseconden.
  lcd.setCursor(0, 1);            // Onderste regel
  lcd.print("Booting in 2");
  delay(500); // De delay van de loop wordt ingesteld, in milliseconden.
  lcd.setCursor(0, 1);            // Onderste regel
  lcd.print("Booting in 1");
  delay(500); // De delay van de loop wordt ingesteld, in milliseconden.
  lcd.clear(); // Clear LCD anders krijg je trailing rommel
  lcd.setCursor(0, 0);            // Bovenste regel  
  lcd.print("  Tijd om te");
  lcd.setCursor(0, 1);            // Onderste regel
  lcd.print("!!!!!RAMMEN!!!!!");
  delay(2000); // De delay van de loop wordt ingesteld, in milliseconden.
  lcd.clear(); // Clear LCD anders krijg je trailing rommel
  
}

void loop() {
  lcd.clear(); // Clear LCD anders krijg je trailing nummers (alternatief: padding programmeren)
  
  PowerStrikereadingA = analogRead(PowerStrikepinA); // Lees PowerStrike pin en save als variabele
  PowerStrikereadingB = analogRead(PowerStrikepinB); // Lees PowerStrike pin en save als variabele

  //set maxima als deze gevonden worden
  if (PowerStrikereadingA > maximumA) {
    maximumA=PowerStrikereadingA;     // Maximum gevonden dus overschrijven
  }
  if (PowerStrikereadingB > maximumB) {
    maximumB=PowerStrikereadingB;     // Maximum gevonden dus overschrijven
  }

  // Print naar LCD
  // Live waarde in de bovenste regel, onderste regel geeft de maxima
    lcd.setCursor(0, 0);            // Bovenste regel
    lcd.print("L1:");
    lcd.print(PowerStrikereadingA); // 'Live' output
    lcd.setCursor(9, 0);            // Bovenste regel, rechts
    lcd.print("L2:");    
    lcd.print(PowerStrikereadingB); // 'Live' output
    lcd.setCursor(0, 1);            // Onderste regel
    lcd.print("M1:");
    lcd.print(maximumA);            // Maximum output    
    lcd.setCursor(9, 1);            // Bovenste regel, rechts
    lcd.print("M2:");
    lcd.print(maximumB);            // Maximum output
 
   // Print output ook naar de serial monitor.
  Serial.print("LIVE = ");             // Aangeven dat dit de 'Live' waarden zijn
  Serial.print(PowerStrikereadingA);   // 'Live' A waarde
  Serial.print(", ");                  // spacer
  Serial.print(PowerStrikereadingB);   // 'Live' B waarde
  Serial.print("   MAX = ");           // Aangeven dat dit de Max waarden zijn
  Serial.print(maximumA);              // Maximum van A
  Serial.print(", ");                  // spacer
  Serial.println(maximumB);            // Maximum van B

  delay(500); // De delay van deze loop wordt ingesteld, in milliseconden.
}
