int main() {

/* PowerStrike v0.06.
 * Twee FSR druk sensoren met live output op een LCD scherm en naar de serial monitor
 * plus was beeps en Rocky tune via de piezo buzzer.*/

#include <LiquidCrystal.h> //Importeer de LCD library

LiquidCrystal lcd(12, 11, 5, 4, 3, 2); // Initialiseren vd LCD en gebruikte pins


// Definieer de constanten
#define NOTE_E5  659       // Toonhoogte en bijbehorende frequentie voor piezo buzzer
#define NOTE_G5  784
#define NOTE_C5  523
#define NOTE_D5  587
#define NOTE_A5  880
#define NOTE_B5  988
#define PowerStrikepin0 A0 // Arduino pin voor druksensor 0
#define PowerStrikepin1 A1 // Arduino pin voor druksensor 1
#define bzzr 8             // Arduino pin voor de Piezo buzzer
#define contra 9           // Arduino pin voor het contrast van de LCD
#define bri 10             // Arduino pin voor de brightness van het LCD


// Definieer de variabelen
int PowerStrikereading0;   // Variabele voor uitlezen druksensor op pin 0
int PowerStrikereading1;   // Variabele voor uitlezen druksensor op pin 1
int maximum0;              // Variabele die de maximale kracht bijhoud
int maximum1;              // Variabele die de maximale kracht bijhoud

// jingle all the way:
int jingleNoten[] = {
  NOTE_E5, NOTE_G5, NOTE_C5, NOTE_D5,
  NOTE_E5,
};
// toonduur: 4 = kwart noot, 8 = achtste noot, enzc, oftewel het tempo:
int jingleTijdPerNoot[] = {
  16, 16, 16, 16,
  4,
};

// Rocky Tune
int rockyNoten[] = {
  NOTE_E5, NOTE_G5, 0, NOTE_A5,
  NOTE_A5, NOTE_B5, 0, NOTE_G5,
  NOTE_E5, NOTE_G5, 0, NOTE_A5,
  NOTE_A5, NOTE_B5, 0, NOTE_G5,
};
int rockyTijdPerNoot[] = {
  16, 8, 8, 1,              // toonduur: 4 = kwart noot, 8 = achtste noot, enzc, oftewel het tempo:
  16, 8, 8, 1,
  16, 8, 8, 1,
  16, 8, 8, 1,
};


// Functies

void muziek(int noten[], int tijden[]) {
  // Invoer van twee arrays: de noten en de tijden per noot
  // Voorbeeld: muziek(rockyNoten,rockyTijdPerNoot)
  int size = sizeof(tijden) / sizeof(int);

  for (int dezeNoot = 0; dezeNoot < size; dezeNoot++) {
    // bereken de toonduur, neem een seconde gedeelt door noot type.
    // toonduurs: kwart noot= 1000 / 4, achtste note = 1000/8, enz
    int nootDuur = 1000 /tijden[dezeNoot];     // hier wordt de tijd van de noot berekend, in ms
    tone(bzzr, noten[dezeNoot], nootDuur);

    // om de onafhankelijke noten goed te horen moet er een korte pauze tussen zitten.
    int pauzeTussenNoten = nootDuur * 1.30;   // Hier heb ik de tijd van de noot  + 30% genomen, dat werkt:
    delay(pauzeTussenNoten);
    noTone(bzzr);                             // stop de tune:
  }
}

void tik(unsigned char delayms){
  // Tik geven via de piezo buzzer, deze is in te stellen; tik(10) geeft 10 ms delay
  analogWrite(8, 250);     // schrijf naar pin 8, volume: gebruik waarden tussen 0-255,
  delay(delayms);          // wacht voor een delay in ms
  analogWrite(8, 0);       // 0 zet het uit
  delay(delayms);          // wacht voor een delay in ms
}
void tikken(int count){
  // Herhalen van tik, tikkerdetik
    while ( count-- )
    {
      tik(20);             // 20 ms is nu de duur van de tik die gegeven wordt, zie functie tik
    }
}


void elcede(int regel, int spatie, String a, int b){
  // funtie voor de invoer van output naar LCD
  lcd.setCursor(regel, spatie);
  lcd.print(a);
  lcd.print(b);
}


void elcedeboot(String a, String b){
  // De elcede functie, input is bovenste en onderste regel.
  lcd.setCursor(0, 0);     // Bovenste regel
  lcd.print(a);
  lcd.setCursor(0, 1);     // Onderste regel
  lcd.print(b);
  delay(500);              // De delay van de loop in milliseconden.
  tik(10);                 // Een enkele korte tik (10 is in ms)
}


void setup() {
  Serial.begin(9600);      // Zet serial communicatie op 9600 baud:
  maximum0=0;              // Zet het maximum op 0
  maximum1=0;              // Zet het maximum op 0

  // LCD instellingen
  lcd.begin(16, 2);         // Stelt in dat de LCD een 16x2 type is
  pinMode(contra, OUTPUT);  // Maak pin 9 als OUTPUT
  pinMode(bri, OUTPUT);     // Maak pin 10 als OUTPUT
  digitalWrite(contra, LOW);// Geeft geen power aan contrast pin. Nu zie je woorden. Best handig.
  analogWrite(bri, 255);    // Geeft volledige power aan screen brightness LED (255)

//FIXME: de tunes draaien niet meer!!!!
//       wat is er aan de hand met de code?
//       vreemd
  muziek(jingleNoten,jingleTijdPerNoot);
//muziek(rockyNoten,rockyTijdPerNoot);

  // Stukje amusement op de LCD met beeping
  // Alsof deze retesnelle code een significante boot tijd heeft
  elcedeboot("**PowerStrike**", "Booting in ");   // Run de elcedeboot functie met deze text
  elcedeboot("**PowerStrike**", "Booting in 3");  // Run de elcedeboot functie met deze text
  elcedeboot("**PowerStrike**", "Booting in 2");  // Run de elcedeboot functie met deze text
  elcedeboot("**PowerStrike**", "Booting in 1");  // Run de elcedeboot functie met deze text
  lcd.clear();                                    // Clear LCD anders krijg je trailing rommel
  elcedeboot("  Tijd om te", "!!!!!RAMMEN!!!!!"); // Run de elcedeboot functie met deze text
  tikken(10);                                     // Tikken met de Piezo buzzer
  lcd.clear();                                    // Clear LCD anders krijg je trailing rommel
}


void loop() {
  lcd.clear(); // Clear LCD anders krijg je trailing rommel
               // TODO: padding programmeren, dat is beter dan dit lcd geflits...

  PowerStrikereading0 = analogRead(PowerStrikepin0); // Lees PowerStrike pin en save als variabele
  PowerStrikereading1 = analogRead(PowerStrikepin1); // Lees PowerStrike pin en save als variabele

  //set maxima als deze gevonden worden
  if (PowerStrikereading0 > maximum0) {
    maximum0=PowerStrikereading0;     // Maximum gevonden dus overschrijven
    muziek(rockyNoten,rockyTijdPerNoot);
  }
  if (PowerStrikereading1 > maximum1) {
    maximum1=PowerStrikereading1;     // Maximum gevonden dus overschrijven
    tik(200);
  }

  // Print naar LCD
  // Live waarde in de bovenste regel, onderste regel geeft de maxima
    elcede(0,0,"L0:",PowerStrikereading0);
    elcede(9,0,"L2:",PowerStrikereading1);
    elcede(0,1,"M0:",maximum0);
    elcede(9,1,"M1:",maximum1);

  // Print output ook naar de serial monitor.
  Serial.print("LIVE = ");             // Aangeven dat dit de 'Live' waarden zijn
  Serial.print(PowerStrikereading0);   // 'Live' A waarde
  Serial.print(", ");                  // spacer
  Serial.print(PowerStrikereading1);   // 'Live' B waarde
  Serial.print("   MAX = ");           // Aangeven dat dit de Max waarden zijn
  Serial.print(maximum0);              // Maximum van A
  Serial.print(", ");                  // spacer
  Serial.println(maximum1);            // Maximum van B
  delay(500); // De delay van deze loop, in ms.
}
    
return 0;
}
