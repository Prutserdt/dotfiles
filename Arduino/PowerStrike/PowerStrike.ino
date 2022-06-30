int main() {

/* PowerStrike v0.08.
 * Twee FSR druk sensoren met live output op een LCD scherm en naar de serial monitor
 * plus was beeps en tunes via de piezo buzzer.*/

#include <LiquidCrystal.h> //Importeer de LCD library

LiquidCrystal lcd(12, 11, 5, 4, 3, 2); // Initialiseren vd LCD en gebruikte pins

// Definieer de constanten
#define NOTE_E5 659       // Toonhoogte en bijbehorende frequentie voor piezo buzzer
#define NOTE_G5 784
#define NOTE_C5 523
#define NOTE_D5 587
#define NOTE_A5 880
#define NOTE_B5 988
#define PowerStrikepin0 A0 // Arduino pin voor druksensor 0
#define PowerStrikepin1 A1 // Arduino pin voor druksensor 1
#define bzzr 8             // Arduino pin voor de Piezo buzzer
#define contra 9           // Arduino pin voor het contrast van de LCD
#define bri 10             // Arduino pin voor de brightness van het LCD
#define schklr 13          // Arduino pin voor de schakelaar


// Definieer de variabelen
int PowerStrikereading0;   // Variabele voor uitlezen druksensor op pin 0
int PowerStrikereading1;   // Variabele voor uitlezen druksensor op pin 1
int maximum0;              // Variabele die de maximale kracht bijhoud
int maximum1;              // Variabele die de maximale kracht bijhoud

String scheld[] = {"~~~~ zucht ~~~~~", "~~~~ slapjes ~~~~", "Beetje harder...",
                   "~~~~~ gaap ~~~~~", "~~~~~ hmmmm ~~~~~", "~~~~ och och ~~~",
                   "~~~~ zzzzz ~~~~~", "~~~~~ tssss ~~~~~", "~~~rozenwater~~~",
                   "~~ natte krant ~", "~~ master Ken ~~~", "~~   aikido   ~~",
                   "~~~ slapjanus ~~", "~~ kussenvuist ~~", "~~~ weakling ~~~",
                   "~~~pillow fist~~", "~~~~~ snurk ~~~~~", "~~~ luiwammes ~~",
                   "~~~~ slome ~~~~~", "~~ kom op man ~~~",
                 }; // scheld Array
int scheldAantal = *(&scheld + 1) - scheld; // Variabele die de lengte is van aantal strings in scheld array

String hulde[] = {"!!    RECORD    !!", "BEAUTIFUL CHAMP!", "GOODNIGHT IRENE!",
                  "      EPICO       ", "          AAAUW!", "     SHA-BAM!   ",
                  "KABOOSH!          ", "       BOOM     "
                   }; // hulde Array
int huldeAantal = *(&hulde + 1) - hulde; // Variable die de lengte is van aantal strings in hulde

// Tune: jingle all the way:
int jingleNoten[] = {
  NOTE_E5, NOTE_G5, NOTE_C5, NOTE_D5,
  NOTE_E5,
};
int jingleTijdPerNoot[] = {
  // toonduur: 4 = kwart noot, 8 = achtste noot, enzc, oftewel het tempo:
  32, 32, 32, 32,
  8,
};
int sizeOfJingle=sizeof(jingleTijdPerNoot);

// Tune: Gonna fly now, Rocky Tune
int rockyNoten[] = {
  NOTE_E5, 0, NOTE_G5, 0, NOTE_A5,
  NOTE_A5, 0, NOTE_B5, 0, NOTE_G5,
  NOTE_E5, 0, NOTE_G5, 0, NOTE_A5,
  NOTE_A5, 0, NOTE_B5, 0, NOTE_G5,
};
int rockyTijdPerNoot[] = {
  // toonduur: 4 = kwart noot, 8 = achtste noot, enzc, oftewel het tempo:
  32, 32, 32, 16, 2,
  32, 32, 32, 16, 2,
  32, 32, 32, 16, 2,
  32, 32, 32, 16, 2,
};
int sizeOfRocky=sizeof(rockyTijdPerNoot);


// Functies
void muziek(int noten[], int tijden[], int grootte) {
  // Muziek functie.
    int size = grootte / sizeof(int);
  //NOTE: int size = sizeof(tijden) / sizeof(int); werkt NIET!!!
  //Blijkbaar lukt het niet of sizeof(tijden)te berekenen.
  //Bovenstaande hack, met grootte, is niet on-elegant

  for (int dezeNoot = 0; dezeNoot < size; dezeNoot++) {
    // bereken de toonduur, neem een seconde gedeelt door noot type.
    // toonduurs: kwart noot= 1000 / 4, achtste note = 1000/8, enz
    int nootDuur = 1000 /tijden[dezeNoot];     // hier wordt de tijd van de noot berekend, in ms
    tone(bzzr, noten[dezeNoot], nootDuur);

    // om de onafhankelijke noten goed te horen moet er een korte pauze tussen zitten.
    int pauzeTussenNoten = nootDuur * 1.30;   // Hier heb ik de tijd van de noot  + 30% genomen, dat werkt:
    delay(pauzeTussenNoten);
    noTone(bzzr);                             // stop de tune
  }
}


void tikken(int count){
  // Enkele of meerdere tikken, tikkerdetik
    while ( count-- )
    {
     analogWrite(8, 255);// schrijf naar pin 8, volume: gebruik waarden tussen 0-255
     delay(20);          // wacht voor een delay in ms
     analogWrite(8, 0);  // 0 zet het uit
     delay(20);          // wacht voor een delay in ms
    }
   delay(50);
}


void elcede(int regel, int spatie, String a, int b){
  // funtie voor de invoer van output naar LCD
  lcd.setCursor(regel, spatie);
  lcd.print(a);
  lcd.print(b);
}


void elcedeBoot(String a, String b){
  // De elcede functie, input is bovenste en onderste regel
  lcd.setCursor(0, 0);     // Bovenste regel
  lcd.print(a);
  lcd.setCursor(0, 1);     // Onderste regel
  lcd.print(b);
  delay(500);              // De delay van de loop in milliseconden
  tikken(1);               // Enkele tik
}


void elcedeMax(){
  // Maxima weergeven in onderste regel van de LCD
    elcede(0,1,"M0:",maximum0);
    elcede(9,1,"M1:",maximum1);
}


void setup() {
  Serial.begin(9600);       // Zet serial communicatie op 9600 baud
  maximum0 = maximum1 = 0;  // Zet het maximum op 0
  pinMode(schklr, INPUT);   // Schakelaartje

  // LCD instellingen
  lcd.begin(16, 2);         // Stelt in dat de LCD een 16x2 type is
  pinMode(contra, OUTPUT);  // Maak pin 9 als OUTPUT
  pinMode(bri, OUTPUT);     // Maak pin 10 als OUTPUT
  digitalWrite(contra, LOW);// Geeft geen power aan contrast pin. Nu zie je woorden. Best handig
  analogWrite(bri, 255);    // Geeft volledige power aan screen brightness LED (255)

  // Stukje amusement
  muziek(rockyNoten,rockyTijdPerNoot, sizeOfRocky);// Rocky tune :-)
  // Boot screen: alsof deze retesnelle code een significante boot tijd heeft
  elcedeBoot("**PowerStrike**", "Booting in ");   // Run de elcedeBoot functie met deze text
  elcedeBoot("**PowerStrike**", "Booting in 3");
  elcedeBoot("**PowerStrike**", "Booting in 2");
  elcedeBoot("**PowerStrike**", "Booting in 1");
  lcd.clear();                                    // Clear LCD anders krijg je trailing rommel
  elcedeBoot("  Tijd om te", "!!!!!RAMMEN!!!!!"); // Run de elcedeBoot functie met deze text
  tikken(10);                                     // Tikken met de Piezo buzzer
  lcd.clear();                                    // Clear LCD anders krijg je trailing rommel
}


void loop() {
  lcd.clear(); // Clear LCD anders krijg je trailing rommel
               // TODO: padding programmeren, dat is beter dan dit lcd geflits...

  PowerStrikereading0 = analogRead(PowerStrikepin0); // Lees PowerStrike pin en save als variabele
  PowerStrikereading1 = analogRead(PowerStrikepin1); // Lees PowerStrike pin en save als variabele

//FIXME: onderstaande IF blocks zijn spaghetti code, dit kan beter en in minder SLOCs
if (PowerStrikereading0+PowerStrikereading1  < 301){ // Deze lage waarden zijn geen maximum waardig
    elcede(0,0, "L0:", PowerStrikereading0);
    elcede(9,0, "L2:", PowerStrikereading1);
    elcedeMax();
 } else if (PowerStrikereading0 + PowerStrikereading1 > 300){
    // als bovenstaande treshhold is gehaald dan een scheld tekst in LCD weergeven
    int scheldNummer = (rand() % scheldAantal) ;   // Kies een random nummer om scheldwoord te kiezen
    String scheldStr = (scheld[scheldNummer]);     // Maak scheldwoord string aan
    lcd.clear();                                   // Clear LCD anders krijg je trailing rommel
    elcede(0, 0, scheldStr, 1);                    // Scheld op de LCD
    elcedeMax();                                   // Blijf maximum weergeven
    tikken(1);
  if (PowerStrikereading0 > maximum0) {
    maximum0 = PowerStrikereading0;                // Maximum gevonden dus overschrijven
    tone(bzzr, 50 + 150 * log(maximum0), 1000 / 4);// Hoe hoger het maximum hoe hoger de toon, log functie
    int huldeNummer = (rand() % huldeAantal) ;     // Maakt random nummer die we gaan gebruiken voor hulde
    String huldeStr = (hulde[huldeNummer]);        // Kies de random hulde
    lcd.clear();                                   // Clear LCD anders krijg je trailing rommel
    elcede(0,0, huldeStr, 1);                      // Geef hulde weer op LCD
    elcedeMax();                                   // Blijf maximum weergeven
    }
  if (PowerStrikereading1 > maximum1) {
    maximum1 = PowerStrikereading1;                // Maximum gevonden dus overschrijven
    delay(200);                                    // Pauze, zodat je de piep van  bovenstaande functie eerst hoort
    tone(bzzr, 50 + 150 * log(maximum1), 1000 / 8);// Hoe hoger het maximum hoe hoger de toon, log functie
    int huldeNummer = (rand() % huldeAantal);      // maakt random nummer die we gaan gebruiken voor text
    String huldeStr = (hulde[huldeNummer]);        // kies de random hulde
    lcd.clear();                                   // Clear LCD anders krijg je trailing rommel
    elcede(0, 0, huldeStr, 1);                     // Knal hulde op LCD
    elcedeMax();                                   // Blijf maximum weergeven
  }
 }

  // Print output ook naar de serial monitor. Want, waarom niet?
  Serial.print("LIVE = ");             // Aangeven dat dit de 'Live' waarden zijn
  Serial.print(PowerStrikereading0);   // 'Live' sensor0 waarde
  Serial.print(", ");                  // spacer
  Serial.print(PowerStrikereading1);   // 'Live' sensor1 waarde
  Serial.print("   MAX = ");           // Aangeven dat dit de Max waarden zijn
  Serial.print(maximum0);              // Maximum van sensor0
  Serial.print(", ");                  // spacer
  Serial.println(maximum1);            // Maximum van sensor1
  delay(500); // De delay van deze loop, in ms

  // Schakelaare om de maxima op nul te zetten, handig voor testen
  // FIXME: onderstaande spaghetti code nog opschonen
  if(digitalRead(schklr) == HIGH){
    maximum0 = maximum1 = 0;
    lcd.clear();                                         // Clear LCD anders krijg je trailing rommel
    elcedeBoot("  Resetten van", "  alle maxima!");      // Geef deze tekst weer in LCD
    tikken(2);
    tikken(2);
    muziek(jingleNoten, jingleTijdPerNoot, sizeOfJingle);// Jingle all the way
 //   delay(20);
    tikken(2);
    tikken(2);
    lcd.clear();
  }

}
return 0;
}
