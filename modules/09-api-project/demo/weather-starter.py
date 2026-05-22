"""
weather-starter.py — skeleton for Module 09.

Copy this to modules/09-api-project/weather/weather.py and fill in the TODOs.
The README shows the complete solution if you get stuck.
"""
import os
import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("OPENWEATHER_API_KEY")
CITY = "San Francisco"
URL = "https://api.openweathermap.org/data/2.5/weather"


def get_weather(city):
    # TODO: build a params dict with keys: q, appid, units
    # Set units to "metric" for Celsius
    params = {}

    # TODO: make a GET request to URL with the params dict
    # Hint: response = requests.get(URL, params=params)
    response = None

    # TODO: call response.raise_for_status() to surface HTTP errors
    # TODO: return response.json()
    pass


def main():
    data = get_weather(CITY)

    # TODO: pull out data["name"], data["main"]["temp"], data["weather"][0]["description"]
    # TODO: print them — e.g. "San Francisco: 14.2°C, overcast clouds"
    pass


if __name__ == "__main__":
    main()
