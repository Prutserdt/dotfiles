#!/usr/bin/env python3
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)

import glob
import os
import pyperclip
import time
import pandas as pd
from PyQt5.QtWidgets import (QLineEdit, QDialog, QDialogButtonBox, QFormLayout, QApplication)

class InputDialog(QDialog):
    """Input screen for cash and house surplus value"""

    def __init__(self, parent=None):
        super().__init__(parent)
        global Huis
        global RaboCash
        RaboCash = QLineEdit(self)
        Huis = QLineEdit(self)
        buttonbox = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel, self)
        layout = QFormLayout(self)
        layout.addRow("Voer Bunq en Rabo cash in:", RaboCash)
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
        Huis = int(Huis)
        RaboCash = int(RaboCash)

def AddCSVtoDataFrame(filename, delimiter, column1, column2):
    """Adding CSV data to the general dataframe,
       different CSVs can be used, the delimter must be set,
       and only two columns are imported to the dataframe"""
    global df  # This dataframe will be used outside of this def, so make it global
    dfx = pd.read_csv(filename, thousands=r'.', sep=delimiter, usecols=[column1, column2])
    dfx.columns = [OmsCol, EurCol] # Harmonizing column names
    dfx[EurCol] = [x.replace(".", "") for x in dfx[EurCol]]  #  Removal of thousand separator
    dfx[EurCol] = [x.replace(",", ".") for x in dfx[EurCol]] #  Change comma to point
    dfx[EurCol] = (dfx[EurCol].astype(float)).apply(int)     # Change the Euro column to integer.
    df = pd.concat([df, dfx])    # Add the temp dataframe to dataframe
    print('=' * 40 + "\n", dfx)  # For debugging

fileDeGIRO = os.path.expanduser("~") + "/Downloads/Portfolio.csv"
searchRabo = os.path.expanduser("~") + "/Downloads/Portefeuille_*"  # Wildcard searching
fileRabo = max(glob.iglob(searchRabo), key=os.path.getctime)        # Find newest file

OmsHuis = "Overwaarde huis     "
OmsCash = "Cash (Rabo en Bunq) "
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
#print('=' * 40 + "\n", df)  # Only for debugging
df = pd.DataFrame(df, columns=[OmsCol, EurCol, AaCol, AminHuisCol])
# Rangschik de volgorde van de kolommen en voeg nieuwe kolommen AA% en AA*% toe

Kapitaal = df[EurCol].sum()  # Calculate the sum of all of the allocations (Kapitaal is Dutch for Capital)
# AA-berekening en de kolommen AA, en AA-huis omzetten naar integer
df[AaCol] = (df[EurCol] / Kapitaal * 100).astype(int) # Calculate values for column AaCol, % of total)
df[AminHuisCol] = (df[EurCol] / (Kapitaal - Huis) * 100).astype(int) # Calculate percentage, not taking into account the surplus value of the house
df.loc[df[AminHuisCol] > 100, AminHuisCol] = "*"  # If >100% then replace by asterix
#print('=' * 40  + "\n", dfx)                      # Only for debugging

# Nieuw dataframe aanmaken met streepjes en totale assets enz
d = {
    EurCol: ["" , Kapitaal, Kapitaal - Huis],
    OmsCol: ["" , "Assets totaal       ", "Assets totaal - huis  "],
    AaCol: ["", "", ""],
    AminHuisCol: ["", "", ""]}
dfx = pd.DataFrame(d)       # Add the list to a new temporary dataframe
df = pd.concat([df, dfx])   # Add the dfx dataframe
#print('=' * 40 + "\n", df)  # Only for debugging

df[OmsCol] = df[OmsCol].apply(lambda x: x[:20]) # Slim the "OmsCol" to 20 characters

datum = time.strptime(time.ctime(os.path.getctime(fileDeGIRO))) # Search date of file: fileDeGIRO
t_stamp =   str(time.strftime("%Y", datum) + "-" + str(time.strftime("%m", datum)) + "-" +  str(time.strftime("%d", datum))) # Create a timestap (YYYYMMDD)

titel = ("\n" '*** <' + t_stamp + "> Assets(zonder huis): " + (Kapitaal - Huis).astype(str) + " Euro." "\n" + "\n")
#print('\n\n') # Only for debugging

# Create a title for the org table, with three stars for level three heading
orgTabelNaam=('#+Name: tbl_', str(t_stamp), '\n')
orgTabelNaam=''.join(orgTabelNaam)

# Transform dataframe to a text string that is ready for Emacs org-mode (with '|' separators)
gesorteerdeLijst = df.to_string(index=False)   # Index verwijderen van dataframe en string maken
gesorteerdeLijst = gesorteerdeLijst.replace('NaN', '')      # Replace NaN values
gesorteerdeLijst = (gesorteerdeLijst.replace("  ", "|"))    # Add separators
gesorteerdeLijst = (gesorteerdeLijst.replace("||", "|"))    # Remove duplicates
gesorteerdeLijst = (gesorteerdeLijst.replace("||", "|"))
gesorteerdeLijst = (gesorteerdeLijst.replace("||", "|"))
gesorteerdeLijst = '|'.join((gesorteerdeLijst.splitlines(True)))
separator= ('|-|-|-|-|') # separator for Emacs org mode (tables)

#print ('\n' + gesorteerdeLijst + '\n')
# Combineer de introductieregels met het dataframe
data = titel + orgTabelNaam + separator + '\n' + gesorteerdeLijst + '\n' + separator # Combineren van introductieregels+dataframe
data = data.replace('Omschrijving', '|Omschrijving')
data = data.replace('AA% AA*%', 'AA% |AA*% ')
data = data.replace('Euro AA%', 'Euro |AA%')
data = data.replace('||||', str(separator)+'\n\n'+str(separator)) # scheiding van twee tabellen
data = data.replace('|Overwaarde', str(separator)+'\n| Overwaarde ')
data = data.replace('|VANECK', 'VANECK')
data = data.replace('- huis', '- huis|')
#print('=' * 40 + "\n", "nieuwe data ---> clipboard:", data, sep="\n")  # Only for debugging

pyperclip.copy(data)

del(AaCol, df, dfx, separator, gesorteerdeLijst, d, data, datum, t_stamp,
    orgTabelNaam, AminHuisCol, EurCol, Huis, Kapitaal, OmsCash, OmsCol,
    OmsHuis, RaboCash, fileDeGIRO, fileRabo, searchRabo, titel)
