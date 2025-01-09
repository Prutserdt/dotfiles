#!/usr/bin/env python3
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)

import glob
import os
import pyperclip
import time
import pandas as pd
from PyQt5.QtWidgets import (QLineEdit, QDialog, QDialogButtonBox, QFormLayout, QApplication, QMessageBox)

class InputDialog(QDialog):
    """Input screen for cash and house surplus value"""

    def __init__(self, parent=None):
        """
        Initialize the InputDialog class.

        Args:
            parent: The parent widget (default: None).
        """
        super().__init__(parent)
        self.rabo_cash = QLineEdit(self)  # Assign QLineEdit object to self.rabo_cash
        self.huis = QLineEdit(self)  # Assign QLineEdit object to self.huis
        buttonbox = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel, self)
        layout = QFormLayout(self)
        layout.addRow("Voer Bunq en Rabo cash in:", self.rabo_cash)
        layout.addRow("Voer overwaarde huis in:", self.huis)
        layout.addWidget(buttonbox)
        buttonbox.accepted.connect(self.accept)
        buttonbox.rejected.connect(self.reject)

    def get_inputs(self):
        """
        Get the input values of rabo_cash and huis.

        Returns:
            A tuple containing the input values of rabo_cash and huis.
        """
        return self.huis.text(), self.rabo_cash.text()

if __name__ == '__main__':
        import sys
        app = QApplication(sys.argv)
        dialog = InputDialog()
        if dialog.exec():
            huis, rabo_cash = dialog.get_inputs()
            huis = int(huis)
            rabo_cash = int(rabo_cash)

def read_csv_and_add_to_dataframe(filename, delimiter, column1, column2):
    """
    Add data of a CSV file to a dataframe.

    Args:
        filename: The path of the CSV file.
        delimiter: The delimiter used in the CSV file.
        column1: The name of the first column.
        column2: The name of the second column.

    Returns:
        The dataframe containing the data from the CSV file.
    """
    try:
        print(filename)
        global asset_allocation_df  # This dataframe will be used outside of this def, so make it global
        temp_asset_allocation_df = pd.read_csv(filename, thousands=r'.', sep=delimiter, usecols=[column1, column2])
        temp_asset_allocation_df.columns = [omschr_col, eur_col]
        temp_asset_allocation_df = temp_asset_allocation_df.dropna(subset=[eur_col])  # Exclude rows with NaN values in the Euro column
        temp_asset_allocation_df[eur_col] = [x.replace(".", "") for x in temp_asset_allocation_df[eur_col]]
        temp_asset_allocation_df[eur_col] = [x.replace(",", ".") for x in temp_asset_allocation_df[eur_col]]
        temp_asset_allocation_df[eur_col] = temp_asset_allocation_df[eur_col].astype(float).apply(int)
        asset_allocation_df = pd.concat([asset_allocation_df, temp_asset_allocation_df])
        print('=' * 40 + "\n", temp_asset_allocation_df)
        return temp_asset_allocation_df
    except FileNotFoundError:
        error_message = f"File '{filename}' not found."   
        QMessageBox.critical(None, "aandelen.py error message", error_message)
        return None
    except pd.errors.EmptyDataError:
        error_message = f"File '{filename}' is empty."
        QMessageBox.critical(None, "aandelen.py error message", error_message)
        return None
    except Exception as e:
        error_message = f"An error occurred while processing file '{filename}': {str(e)}"
        QMessageBox.critical(None, "aandelen.py error message", error_message)
        return None

def replace_data(data, replacements):
    """
    Replaces specific columns in the given data with their corresponding replacements.

    Args:
        data (str): The input data to modify.
        replacements (list): A list of tuples representing the before/after text replacements.

    Returns:
        str: The modified data with the specified replacements applied.
    """
    for before, after in replacements:
        data = data.replace(before, after)
    return data

file_degiro = os.path.expanduser("~") + "/Downloads/Portfolio.csv"
search_rabo = os.path.expanduser("~") + "/Downloads/Portefeuille_*.csv"  # Wildcard searching
latest_file_rabo = max(glob.iglob(search_rabo), key=os.path.getctime)        # Find newest file

omschr_huis = "Overwaarde huis     "
omschr_cash = "Cash (Rabo en Bunq) "
# Namen van kolommen die ik ga gebruiken:
eur_col = "Euro"                     # Euro column naam
omschr_col = "Omschrijving        "  # Omschrijving column naam
asset_allocation_col = "AA%"         # Asset Allocation column naam
a_min_huis_col = "AA*%"              # Asset Allocation zonder huis berekend column naam

asset_allocation_df = pd.DataFrame() # Create a new dataframe
read_csv_and_add_to_dataframe(file_degiro, ",", "Waarde in EUR", "Product") # Add DeGIRO data to dataframe
read_csv_and_add_to_dataframe(latest_file_rabo, ";", "Naam", "Huidig €") # Add data from csv files to dataframe
# Create a new dataframe with surplus value house and Cash amount
asset_values_dict = {
    omschr_col: [omschr_huis, omschr_cash],    # kolom omschrijving invullen
    eur_col: [huis, rabo_cash]}      # kolom euros invullen
temp_asset_allocation_df = pd.DataFrame(asset_values_dict)
asset_allocation_df = pd.concat([asset_allocation_df, temp_asset_allocation_df])
# Sortt by euros, descencding
asset_allocation_df = asset_allocation_df.sort_values(by=eur_col, ascending=False)
print('=' * 40 + "\n", asset_allocation_df)  # Only for debugging
asset_allocation_df = pd.DataFrame(asset_allocation_df, columns=[omschr_col, eur_col, asset_allocation_col, a_min_huis_col])

kapitaal = asset_allocation_df[eur_col].sum()  # Calculate the sum of all of the allocations (kapitaal is Dutch for Capital)
# AA-berekening en de kolommen AA, en AA-huis omzetten naar integer
asset_allocation_df[asset_allocation_col] = (asset_allocation_df[eur_col] / kapitaal * 100).astype(int) # Calculate values for column asset_allocation_col, % of total)
asset_allocation_df[a_min_huis_col] = (asset_allocation_df[eur_col] / (kapitaal - huis) * 100).astype(int) # Calculate percentage, not taking into account the surplus value of the house
asset_allocation_df.loc[asset_allocation_df[a_min_huis_col] > 100, a_min_huis_col] = "*"  # If >100% then replace by asterix
print('=' * 40  + "\n", asset_allocation_df)                      # Only for debugging

# Nieuw dataframe aanmaken met streepjes en totale assets enz
asset_values_dict = {
    eur_col: ["" , kapitaal, kapitaal - huis],
    omschr_col: ["" , "Assets totaal       ", "Assets totaal - huis  "],
    asset_allocation_col: ["", "", ""],
    a_min_huis_col: ["", "", ""]}
temp_asset_allocation_df = pd.DataFrame(asset_values_dict)       # Add the list to a new temporary dataframe
asset_allocation_df = pd.concat([asset_allocation_df, temp_asset_allocation_df])   # Add the temp_asset_allocation_df dataframe
print('=' * 40 + "\n", asset_allocation_df)  # Only for debugging

asset_allocation_df[omschr_col] = asset_allocation_df[omschr_col].apply(lambda x: x[:20]) # Slim the "omschr_col" to 20 characters

datum = time.strptime(time.ctime(os.path.getctime(file_degiro))) # Search date of file: file_degiro
t_stamp =   str(time.strftime("%Y", datum) + "-" + str(time.strftime("%m", datum)) + "-" +  str(time.strftime("%d", datum))) # Create a timestap (YYYYMMDD)

title = ("\n" '*** <' + t_stamp + "> Assets(zonder huis): " + (kapitaal - huis).astype(str) + " Euro.\n\n")
print('\n\n') # Only for debugging

# Create a title for the org table, with three stars for level three heading
org_table_name=('#+Name: tbl_', str(t_stamp), '\n')
org_table_name=''.join(org_table_name)

# Transform dataframe to a text string that is ready for Emacs org-mode (with '|' separators)
sorted_list = asset_allocation_df.to_string(index=False)   # Index verwijderen van dataframe en string maken
sorted_list = sorted_list.replace('NaN', '')      # Replace NaN values
sorted_list = (sorted_list.replace("  ", "|"))    # Add separators
for i in range(3):
    sorted_list = sorted_list.replace("||", "|")
sorted_list = '|'.join((sorted_list.splitlines(True)))
separator= ('|-|-|-|-|') # separator for Emacs org mode (tables)

print ('\n' + sorted_list + '\n')
# Combineer de introductieregels met het dataframe
data = title + org_table_name + separator + '\n' + sorted_list + '\n' + separator # Combineren van introductieregels+dataframe

replacements = [
    ('Omschrijving',       '|Omschrijving'),
    ('AA% AA*%',           'AA% |AA*% '),
    ('Euro AA%',           'Euro |AA%'),
    ('||||',               '|-|-|-|-|\n\n|-|-|-|-|'),
    ('|Overwaarde',        '|-|-|-|-|\n| Overwaarde '),
    ('|VANECK',            'VANECK'),
    ('- huis',             '- huis|')
]

data = replace_data(data, replacements)
print('=' * 40 + "\n", "nieuwe data ---> clipboard:", data, sep="\n")  # Only for debugging

pyperclip.copy(data)

del(asset_allocation_col, asset_allocation_df, temp_asset_allocation_df, separator, sorted_list, data, datum, t_stamp, org_table_name, a_min_huis_col, eur_col, huis, kapitaal, omschr_cash, omschr_col, omschr_huis, rabo_cash, file_degiro, latest_file_rabo, search_rabo, title)
