import requests
import pandas as pd

LAT = 44.4325
LON = 26.1039

START = "2015-01-01"
END = "2024-12-31"

def map_weathercode(code):
    if code == 0:
        return "Sunny"
    elif code in [1, 2]:
        return "Partly Cloudy"
    elif code in [51, 53, 55, 61, 63, 65, 80, 81, 82, 95, 96, 99]:
        return "Rainy"
    elif code in [71, 73, 75]:
        return "Snowy"
    else:
        return "Sunny"

url = "https://archive-api.open-meteo.com/v1/archive"
params = {
    "latitude": LAT,
    "longitude": LON,
    "start_date": START,
    "end_date": END,
    "daily": "weathercode,temperature_2m_max,temperature_2m_min",
    "timezone": "Europe/Bucharest"
}

response = requests.get(url, params=params)
data = response.json()

df = pd.DataFrame({
    "date": data["daily"]["time"],
    "weather_code": data["daily"]["weathercode"],
    "temp_max": data["daily"]["temperature_2m_max"],
    "temp_min": data["daily"]["temperature_2m_min"]
})

df["weather"] = df["weather_code"].apply(map_weathercode)

df.to_csv("vreme_bucuresti.csv", index=False)

print(df.head())
