#!/usr/bin/env python3
import glob
import os
import pandas as pd
import pyperclip
import time

from PyQt5.QtWidgets import (QLineEdit, QDialog, QDialogButtonBox, QFormLayout, QApplication)

# Script dat een overzicht van asset allocations maakt en deze saved in clipboard.
# Een gedeelte wordt handmatig ingevoerd in een input scherm (InputDialog).
# De rest wordt uit twee csv files van beleggingsportfolios geextraheerd.
# Dit wordt samengevoegd en de AA% worden berekend. Plus was stylistische toevoegingen.
# Deze data wordt in het systeem clipboard opgeslagen.


# Open een simpel inputscherm voor handmatige invoer van spaargeld en overwaarde huis.
# gebaseerd op: https://stackoverflow.com/questions/56019273/how-can-i-get-more-input-text-in-pyqt5-inputdialog
class InputDialog(QDialog):
    """Invoerscherm voor hoeveelheid spaargeld en overwaarde huis"""
    def __init__(self, parent = None):
        super().__init__(parent)
        global Huis         #Zorg ervoor dat variabel buiten dialog te gebruiken is.
        global Spaargeld    #Zorg ervoor dat variabel buiten dialog te gebruiken is.
        Spaargeld = QLineEdit(self)
        Huis = QLineEdit(self)
        buttonBox = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel, self);
        layout = QFormLayout(self)
        layout.addRow("Voer spaarsaldo in:", Spaargeld)
        layout.addRow("Voer overwaarde huis in:", Huis)
        layout.addWidget(buttonBox)
        buttonBox.accepted.connect(self.accept)
        buttonBox.rejected.connect(self.reject)
        
    def getInputs(self):
        return (Spaargeld.text(), Huis.text())
    
if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)
    dialog = InputDialog()
    if dialog.exec():
        Spaargeld, Huis = dialog.getInputs()
        Huis=int(Huis)              # Integer nodig voor latere berekeningen
        Spaargeld = int(Spaargeld)    # Integer nodig voor latere berekeningen


# CSV data aan dataframe toevoegen
def AddCSVtoDataFrame(filename, delimiter, Kolom1, Kolom2):
    """Opbouwen van het dataframe uit meerder csv bestanden"""
    global df # Dit dataframe wordt gebruikt buiten de deze def, dus global maken
    # Create a temp dataframe:
    dfx = pd.read_csv(filename,thousands = r'.',sep = delimiter, usecols = [Kolom1,Kolom2])
    # Harmoniseer de kolomnamen
    dfx.columns = [OmsCol, EurCol] 
    # Harmoniseer notatie. Verwijder punt als duizend separator, en wissel komma om met punt
    dfx[EurCol] = [x.replace(".", "") for x in dfx[EurCol]]
    dfx[EurCol] = [x.replace(",", ".") for x in dfx[EurCol]]
    # Verander kolom Euro naar integer
    dfx[EurCol] = (dfx[EurCol].astype(float)).apply(int)
    # Toevoegen van tijdelijke dataframe aan bestaande dataframe
    df = pd.concat([df, dfx])
    print(separ+"\n",dfx) # Alleen voor debugging gebruik


# Aanmaken van separatoren (gebruikt voor opmaak).
def CreateSep(teken, herhalingen):
    x = str("")   # Maak x aan als een lege string
    for a in range(0,herhalingen): x = x + teken
    return(x)

   
# Aanmaken van een aantal variabelen(file locaties, column omsschrijvingen enz
fileDeGIRO = os.path.expanduser("~")+"/Downloads/Portfolio.csv"

# Locatie Rabo portfolio. Zoek meest recente file mbv wildcard:
searchRabo = os.path.expanduser("~")+"/Downloads/Portfolio_36*"# Wildcard zoeken
fileRabo = max(glob.iglob(searchRabo), key = os.path.getctime)      # Zoek nieuwste 
# Separator lijn die ik her en der gebruik
separ = CreateSep("=",80) # separator teken en lengte

# Omschrijving van overwaarde huis en Spaargeld
OmsHuis = "Overwaarde huis     "
OmsSpaar = "Spaargeld           "
# Namen van kolommen die ik ga gebruiken:
EurCol = "Euro"                   # Euro column naam
OmsCol = "Omschrijving        "   # Omschrijving column naam
AaCol = "AA%"                     # Asset Allocation column naam
AminHuisCol = "AA*%"              # Asset Allocation zonder huis berekend column naam

# Aanmaken van een leeg dataframe
df = pd.DataFrame()

# Toevoegen van data uit csv files aan het lege datframe.
#                (filename,   delimiter, Kolom1,          Kolom2    ) 
AddCSVtoDataFrame(fileRabo,   ";",       "Titel",         "Waarde €")
AddCSVtoDataFrame(fileDeGIRO, ",",       "Waarde in EUR", "Product" )

# Nieuw dataframe aanmaken met overwaarde huis en spaargeld data
d={
    OmsCol:[OmsHuis,OmsSpaar ], # kolom omschrijving invullen
    EurCol:[Huis,   Spaargeld]} # kolom euros invullen
dfx = pd.DataFrame(d)

# Samenvoegen van dataframes
df=pd.concat([df,dfx])

# Sorteer op euros, aflopend (ascending=False)
df = df.sort_values(by = EurCol, ascending = False)
print(separ+"\n",df) # Alleen voor debugging gebruik
# Rangschik de volgorde van de kolommen en voeg nieuwe kolommen AA% en AA*% toe
df = pd.DataFrame(df,columns = [OmsCol, EurCol, AaCol, AminHuisCol])
# Berekenen het totaal van het kapitaal. Wordt gebruikt voor AA berekeningen
Kapitaal = df[EurCol].sum()
# AA berekeningen en de kolommen AA, en AA-huis omzetten naar integer
df[AaCol] = (df[EurCol]/Kapitaal*100).astype(int)
df[AminHuisCol] = (df[EurCol]/(Kapitaal-Huis)*100).astype(int)
df.loc[df[AminHuisCol] > 100, AminHuisCol] = "*" #Als >100% dan een sterretje geven
print(separ+"\n",df) # Alleen voor debugging gebruik

# Extra regels toevoegen onder de tabel (separatoren en AA waarden)
# Separator lijnen aanmaken
#                  (teken, lengte)
SepKort = CreateSep("-",   6     )
SepLang = CreateSep("-",   20    )

# Nieuw dataframe aanmaken met streepjes en totale assets enz
d={
    EurCol:     [SepKort, Kapitaal,               Kapitaal-Huis          ],
    OmsCol:     [SepLang, "Assets totaal       ", "Assets totaal -huis  "],
    AaCol:      ["+   ",  "",                     ""                     ],   
    AminHuisCol:["",      "",                     ""                     ]}    
dfx = pd.DataFrame(d)

# Samenvoegen van dataframes
df=pd.concat([df,dfx])

# De kolom omschrijving afslanken tot 20 tekens
df[OmsCol] = df[OmsCol].apply(lambda x: x[:20])

# Maak introductie regels en combineer dit met de dataframe.
# Datum vinden van het bestand:fileDeGIRO
datum = time.strptime(time.ctime(os.path.getctime(fileDeGIRO)))
# Maak een timestamp string aan als deze: 01JAN22
t_stamp = str(time.strftime("%d", datum)) + str(time.strftime("%b", datum)) + str(time.strftime("%y", datum))
# Introductie regels (separator/datum+assets/separator)
deel1 = (separ + "\n" + t_stamp+", assets(zonder huis): " + (Kapitaal-Huis).astype(str)+" Euro." "\n" + separ + "\n")
# Combineer de introductieregels met de dataframe
deel2 = df.to_string(index = False)     # Index verwijderen van dataframe en string maken
deel2 = deel2.replace('NaN', '')        # Verwijder NaN waarden
data = deel1 + deel2                    # Combineren van introductieregels+dataframe
df = dfx = deel1 = deel2 = None         # Wissen van data (garbage collection)
print(separ+"\n","data ---> clipboard:",data, sep = "\n") # Alleen voor debugging gebruik

# Schrijf data weg in het clipboard
pyperclip.copy(data)
