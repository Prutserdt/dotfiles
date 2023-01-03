#!/usr/bin/env python3
import glob, os, pyperclip, time
import pandas as pd
from PyQt5.QtWidgets import (QLineEdit, QDialog, QDialogButtonBox, QFormLayout, QApplication)

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

def AddCSVtoDataFrame(filename, delimiter, column1, column2):
    """Building a dataframe from several CSV files"""
    global df  # This dataframe will be used outside of this def, so make it global
    dfx = pd.read_csv(filename, thousands=r'.', sep=delimiter, usecols=[column1, column2])
    dfx.columns = [OmsCol, EurCol] # Harmonizing column names
    dfx[EurCol] = [x.replace(".", "") for x in dfx[EurCol]]  #  Removal of thousand separator
    dfx[EurCol] = [x.replace(",", ".") for x in dfx[EurCol]] #  Change comma to point
    dfx[EurCol] = (dfx[EurCol].astype(float)).apply(int)     # Change the Euro column to integer.
    df = pd.concat([df, dfx])    # Add the temp dataframe to dataframe
    print('=' * 40 + "\n", dfx)  # For debugging

fileDeGIRO = os.path.expanduser("~") + "/Downloads/Portfolio.csv"
searchRabo = os.path.expanduser("~") + "/Downloads/Portefeuille-*"  # Wildcard searching
fileRabo = max(glob.iglob(searchRabo), key=os.path.getctime)        # Find newest file
OmsHuis = "Overwaarde huis     "
OmsCash = "RaboCash            "
# Namen van kolommen die ik ga gebruiken:
EurCol = "Euro"                     # Euro column naam
OmsCol = "Omschrijving        "     # Omschrijving column naam
AaCol = "AA%"                       # Asset Allocation column naam
AminHuisCol = "AA*%"                # Asset Allocation zonder huis berekend column naam
df = pd.DataFrame() # Create a new dataframe
AddCSVtoDataFrame(fileRabo, ";", "Naam", "Huidig €") # Add data from csv files to dataframe
df.drop(3,0,inplace=True) # Remove the bottom row of the Rabobank CSV, it is empty
AddCSVtoDataFrame(fileDeGIRO, ",", "Waarde in EUR", "Product") # Add DeGIRO data to dataframe
# Create a new dataframe with surplus value house and Cash amount
d = {
    OmsCol: [OmsHuis, OmsCash],    # kolom omschrijving invullen
    EurCol: [Huis, RaboCash]}      # kolom euros invullen
dfx = pd.DataFrame(d)
# Samenvoegen van dataframes
df = pd.concat([df, dfx])
# Sorteer op euros, aflopend (ascending=False)
df = df.sort_values(by=EurCol, ascending=False)
print('=' * 40 + "\n", df)  # Alleen voor debugging gebruik
df = pd.DataFrame(df, columns=[OmsCol, EurCol, AaCol, AminHuisCol])
# Rangschik de volgorde van de kolommen en voeg nieuwe kolommen AA% en AA*% toe
# Berekenen het totaal van het kapitaal. Wordt gebruikt voor AA-berekening
Kapitaal = df[EurCol].sum()
# AA-berekening en de kolommen AA, en AA-huis omzetten naar integer
df[AaCol] = (df[EurCol] / Kapitaal * 100).astype(int)
df[AminHuisCol] = (df[EurCol] / (Kapitaal - Huis) * 100).astype(int)
df.loc[df[AminHuisCol] > 100, AminHuisCol] = "*"  # Als >100% dan een sterretje geven
print('=' * 40  + "\n", dfx)  # Alleen voor debugging gebruik

# Nieuw dataframe aanmaken met streepjes en totale assets enz
d = {
    EurCol: ["" , Kapitaal, Kapitaal - Huis],
    OmsCol: ["" , "Assets totaal       ", "Assets totaal - huis  "],
    AaCol: ["", "", ""],
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
# De titel voor in org mode (met drie sterren)
titel = ("\n" '*** ' + t_stamp + ", assets(zonder huis): " + (Kapitaal - Huis).astype(str) + " Euro." "\n" + "\n")
print('\n\n')
orgTabelNaam=('#+Name: tbl_', str(t_stamp), '\n')
orgTabelNaam=''.join(orgTabelNaam)

# Transformeer dataframe tot een text string met Emacs org mode table separatoren (|)
gesorteerdeLijst = df.to_string(index=False)   # Index verwijderen van dataframe en string maken
gesorteerdeLijst = gesorteerdeLijst.replace('NaN', '')      # Replace NaN values
gesorteerdeLijst = (gesorteerdeLijst.replace("  ", "|"))    # Add separators
gesorteerdeLijst = (gesorteerdeLijst.replace("||", "|"))    # Remove duplicates
gesorteerdeLijst = (gesorteerdeLijst.replace("||", "|"))
gesorteerdeLijst = (gesorteerdeLijst.replace("||", "|"))
gesorteerdeLijst = '|'.join((gesorteerdeLijst.splitlines(True)))

separator= ('|-|-|-|-|') # separator for Emacs org mode (tables)

# Combineer de introductieregels met het dataframe
data = titel + orgTabelNaam + separator +'\n' + gesorteerdeLijst + '\n'+separator               # Combineren van introductieregels+dataframe
data = data.replace('Omschrijving', '|Omschrijving')    # Verwijder NaN waarden
data = data.replace('AA% AA*%', 'AA% |AA*%')    # Verwijder NaN waarden
data = data.replace('Euro AA%', 'Euro |AA%')    # Verwijder NaN waarden
data = data.replace('||||', str(separator)+'\n\n'+str(separator))    # Verwijder NaN waarden
data = data.replace('|Overwaarde', str(separator)+'\n| Overwaarde ')    # Verwijder NaN waarden

print('=' * 40 + "\n", "nieuwe data ---> clipboard:", data, sep="\n")  # Alleen voor debugging gebruik
pyperclip.copy(data)

del(AaCol, df, dfx, separator, gesorteerdeLijst, d, data, datum, t_stamp,
    orgTabelNaam, AminHuisCol, EurCol, Huis, Kapitaal, OmsCash, OmsCol,
    OmsHuis, RaboCash, fileDeGIRO, fileRabo, searchRabo, titel)
