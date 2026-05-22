import requests

LAT = 41.0670
LON = -73.7076

def get_weather(lat, lon):
    url = "https://api.open-meteo.com/v1/forecast"
    params = {
        "latitude": lat,
        "longitude": lon,
        "current": "temperature_2m,wind_speed_10m,weather_code",
    }
    response = requests.get(url, params=params)
    return response.json()["current"]

weather = get_weather(LAT, LON)

print(f"Temperature : {weather['temperature_2m']}°C")
print(f"Wind speed  : {weather['wind_speed_10m']} km/h")
print(f"Fetched at  : {weather['time']}")
