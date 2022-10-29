#!/usr/bin/env python3
import glob
import os
import pandas as pd
import pyperclip
import time

from PyQt5.QtWidgets import (QLineEdit, QDialog, QDialogButtonBox, QFormLayout, QApplication)


# Script dat een overzicht van asset allocations maakt en deze saved in clipboard.
# Een gedeelte wordt handmatig ingevoerd in een input scherm (InputDialog).
# De rest wordt uit twee csv files van beleggingsportfolio's geëxtraheerd.
# Dit wordt samengevoegd en de AA% worden berekend. Plus was stylistische toevoegingen.
# Deze data wordt in het systeem clipboard opgeslagen.


# Open een simpel inputscherm voor handmatige invoer van cash geld en overwaarde huis.
# gebaseerd op: https://stackoverflow.com/questions/56019273/how-can-i-get-more-input-text-in-pyqt5-inputdialog
class InputDialog(QDialog):
    """Invoerscherm voor hoeveelheid geld en overwaarde huis"""

    def __init__(self, parent=None):
        super().__init__(parent)
        global Huis  # Zorg ervoor dat variabel buiten dialog te gebruiken is.
        global RaboCash  # Zorg ervoor dat variabel buiten dialog te gebruiken is.
        RaboCash = QLineEdit(self)
        Huis = QLineEdit(self)
        buttonbox = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel, self)
        layout = QFormLayout(self)
        layout.addRow("Voer Rabo cash in (spaar+courant):", RaboCash)
        layout.addRow("Voer overwaarde huis in:", Huis)
        layout.addWidget(buttonbox)
        buttonbox.accepted.connect(self.accept)
        buttonbox.rejected.connect(self.reject)

    def getinputs(self):
        return RaboCash.text(), Huis.text()


if __name__ == '__main__':
    import sys

    app = QApplication(sys.argv)
    dialog = InputDialog()
    if dialog.exec():
        RaboCash, Huis = dialog.getinputs()
        Huis = int(Huis)          # Moet integer zijn voor latere berekening
        RaboCash = int(RaboCash)  # Moet integer zijn voor latere berekening


# CSV data aan dataframe toevoegen
def AddCSVtoDataFrame(filename, delimiter, kolom1, kolom2):
    """Opbouwen van het dataframe uit meerdere csv-bestanden"""
    global df  # Dit dataframe wordt gebruikt buiten de deze def, dus global maken
    # Create a temp dataframe:
    dfx = pd.read_csv(filename, thousands=r'.', sep=delimiter, usecols=[kolom1, kolom2])
    # Harmoniseer de kolomnamen
    dfx.columns = [OmsCol, EurCol]
    # Harmoniseer notatie. Verwijder punt als duizend separator, en wissel komma om met punt
    dfx[EurCol] = [x.replace(".", "") for x in dfx[EurCol]]
    dfx[EurCol] = [x.replace(",", ".") for x in dfx[EurCol]]
    # Verander kolom Euro naar integer
    dfx[EurCol] = (dfx[EurCol].astype(float)).apply(int)
    # Toevoegen van tijdelijke dataframe aan bestaande dataframe
    df = pd.concat([df, dfx])
    print('=' * 40 + "\n", dfx)  # Alleen voor debugging gebruik

# Aanmaken van een aantal variabelen.
# Locatie van DeGIRO porfolio:
fileDeGIRO = os.path.expanduser("~") + "/Downloads/Portfolio.csv"
# Locatie Rabo portfolio. Zoek eerst de meest recente file mbv wildcard:
searchRabo = os.path.expanduser("~") + "/Downloads/Portefeuille-36*"  # Wildcard zoeken
# Daarna de nieuwste file zoeken in directory
fileRabo = max(glob.iglob(searchRabo), key=os.path.getctime)       # Zoek nieuwste
# Separator lijn die ik her en der gebruik
# separ = '=' * 40 # separator teken en lengte

# Omschrijving van overwaarde huis en cash geld
OmsHuis = "Overwaarde huis     "
OmsCash = "RaboCash            "
# Namen van kolommen die ik ga gebruiken:
EurCol = "Euro"                     # Euro column naam
OmsCol = "Omschrijving        "     # Omschrijving column naam
AaCol = "AA%"                       # Asset Allocation column naam
AminHuisCol = "AA*%"                # Asset Allocation zonder huis berekend column naam

# Aanmaken van dataframes van de twee portefeuilles en samenvoegen dataframes.
# Aanmaken van een leeg dataframe
df = pd.DataFrame()
# Toevoegen van data uit csv files aan het lege dataframe.
AddCSVtoDataFrame(fileRabo, ";", "Naam", "Huidig €")
#De onderste regel van de rabobank csv is een lege regel dus verwijderen:
df.drop(3,0,inplace=True)

# Nu de DeGIRO data toevoegen:
AddCSVtoDataFrame(fileDeGIRO, ",", "Waarde in EUR", "Product")
# Nieuw dataframe aanmaken met overwaarde huis en spaargeld data
d = {
    OmsCol: [OmsHuis, OmsCash],    # kolom omschrijving invullen
    EurCol: [Huis, RaboCash]}      # kolom euros invullen
dfx = pd.DataFrame(d)
# Samenvoegen van dataframes
df = pd.concat([df, dfx])
# Sorteer op euros, aflopend (ascending=False)
df = df.sort_values(by=EurCol, ascending=False)
print('=' * 40 + "\n", df)  # Alleen voor debugging gebruik

# Asset allocations berekenen en toevoegen aan dataframe
# Rangschik de volgorde van de kolommen en voeg nieuwe kolommen AA% en AA*% toe
df = pd.DataFrame(df, columns=[OmsCol, EurCol, AaCol, AminHuisCol])
# Berekenen het totaal van het kapitaal. Wordt gebruikt voor AA-berekening
Kapitaal = df[EurCol].sum()
# AA-berekening en de kolommen AA, en AA-huis omzetten naar integer
df[AaCol] = (df[EurCol] / Kapitaal * 100).astype(int)
df[AminHuisCol] = (df[EurCol] / (Kapitaal - Huis) * 100).astype(int)
df.loc[df[AminHuisCol] > 100, AminHuisCol] = "*"  # Als >100% dan een sterretje geven
print('=' * 40  + "\n", dfx)  # Alleen voor debugging gebruik

# Nieuw dataframe aanmaken met streepjes en totale assets enz
d = {
    EurCol: ["-" * 6, Kapitaal, Kapitaal - Huis],
    OmsCol: ["-" * 20, "Assets totaal       ", "Assets totaal -huis  "],
    AaCol: ["+   ", "", ""],
    AminHuisCol: ["", "", ""]}
dfx = pd.DataFrame(d)
# Samenvoegen van dataframes
df = pd.concat([df, dfx])
print('=' * 40 + "\n", df)  # Alleen voor debugging gebruik

# De kolom omschrijving afslanken tot 20 tekens
df[OmsCol] = df[OmsCol].apply(lambda x: x[:20])

# Maak introductie regels en combineer dit met de dataframe.
# Datum vinden van het bestand:fileDeGIRO
datum = time.strptime(time.ctime(os.path.getctime(fileDeGIRO)))
# Maak een timestamp als 20230131
t_stamp =   str(time.strftime("%Y", datum) + str(time.strftime("%m", datum)) + str(time.strftime("%d", datum)))
# Introductie regels (separator/datum+assets/separator)
deel1 = ('=' * 40 + "\n" + t_stamp + ", assets(zonder huis): " + (Kapitaal - Huis).astype(str) + " Euro." "\n" + '=' * 40 + "\n")
# Combineer de introductieregels met het dataframe
deel2 = df.to_string(index=False)   # Index verwijderen van dataframe en string maken
deel2 = deel2.replace('NaN', '')    # Verwijder NaN waarden
data = deel1 + deel2                # Combineren van introductieregels+dataframe
print('=' * 40 + "\n", "data ---> clipboard:", data, sep="\n")  # Alleen voor debugging gebruik

# Schrijf data weg in het clipboard
pyperclip.copy(data)

# Wissen van data (garbage collection)
del(AaCol , df , dfx , deel1 , deel2 , d , data ,   datum , t_stamp)
del(AminHuisCol , EurCol , Huis , Kapitaal ,OmsCash , OmsCol , OmsHuis)
del(RaboCash , fileDeGIRO , fileRabo , searchRabo)