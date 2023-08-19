#!/usr/bin/env python3
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)

import requests
import json
from datetime import datetime
from notifypy import Notify

def coingecko():
    global rate
    global time
    url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur&include_last_updated_at=true"

    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        rate = data["bitcoin"]["eur"]
        timestamp = data["bitcoin"]["last_updated_at"] # get timestamp
        date_time = datetime.fromtimestamp(timestamp)  # convert to an datetime object
        time = date_time.strftime("%H:%M:%S %d%h%y")   # convert to string
    else:
        rate = time = "Error fetching data"

def output_to_notifications():
    notification = Notify()
    notification.title = "Bitcoin price (euro):"
    notification.message = rate, time
    notification.send()

# aanroepen van gewenste functies
coingecko()
output_to_notifications()
