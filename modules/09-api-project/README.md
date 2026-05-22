# Module 09 — Hitting an API

> **You'll be able to:** Write a Python script that fetches live data from an API, using environment variables to keep secrets out of your code.
> **Time:** ~60 min
> **Prereqs:** Modules 06, 08

## Why this matters

Most software you'll write talks to other software over the internet. APIs are how services expose their data and functionality. Once you can hit an API from code you wrote, you can fetch weather, send messages, process payments, generate images — anything with a public interface. This module builds the simplest possible version of that, end to end.

## Setup

```bash
cd ~/Developer/power-user-principles
mkdir -p modules/09-api-project/weather
cd modules/09-api-project/weather
```

---

## Get an OpenWeather API Key

1. Go to [openweathermap.org](https://openweathermap.org) and create a free account
2. Go to your profile → **API keys**
3. Copy your default API key (or generate a new one)

Free tier includes 60 calls/minute, 1 million calls/month — more than enough for this module.

> The API key activates within a few minutes of account creation. If your first request fails, wait 5 minutes and try again.

---

## What is an API?

An API (Application Programming Interface) is a defined way to ask a service for something.

For OpenWeather, the request looks like:

```
GET https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_KEY&units=metric
```

Breaking it down:
- `GET` — the HTTP method (we're asking for data, not sending it)
- `https://api.openweathermap.org/data/2.5/weather` — the endpoint (which service and which function)
- `?q=London` — a query parameter (the city)
- `&appid=YOUR_KEY` — your API key (proves who you are)
- `&units=metric` — another parameter (Celsius instead of Kelvin)

The service responds with JSON — structured data you can read with code.

**Try it first with curl:**
```bash
curl "https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_KEY&units=metric"
```

You'll see a wall of JSON. That's the raw response.

---

## Environment Variables and .env

Never put an API key in your code. If you commit it, it's public. If you share the file, the key goes with it.

The pattern:
1. Put secrets in a file called `.env`
2. Add `.env` to `.gitignore`
3. Read the secrets from environment variables in your code

**Create `.env`:**
```bash
touch .env
echo "OPENWEATHER_API_KEY=your_actual_key_here" > .env
```

**Add to `.gitignore`:**
```bash
echo ".env" >> .gitignore
```

**Check — never commit this:**
```bash
git status     # .env should NOT appear as an untracked file
```

---

## Create a Virtual Environment

A virtual environment is an isolated Python installation for this project. Libraries installed here don't affect anything else on your system.

```bash
python -m venv .venv
source .venv/bin/activate     # Mac / WSL
```

Your prompt changes to show `(.venv)`. That means you're inside the virtual environment.

---

## Install Dependencies

```bash
pip install requests python-dotenv
```

- `requests` — the standard Python library for making HTTP requests
- `python-dotenv` — reads `.env` files and loads them as environment variables

Save the dependency list:
```bash
pip freeze > requirements.txt
```

---

## Write the Script

There's a starter with TODOs in `demo/weather-starter.py` if you want a scaffold to fill in rather than typing from scratch. The complete solution is below.

Create `weather.py`:

```python
import os
import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("OPENWEATHER_API_KEY")
CITY = "San Francisco"
URL = "https://api.openweathermap.org/data/2.5/weather"

def get_weather(city):
    params = {
        "q": city,
        "appid": API_KEY,
        "units": "metric",
    }
    response = requests.get(URL, params=params)
    response.raise_for_status()
    return response.json()

def main():
    data = get_weather(CITY)
    name = data["name"]
    temp = data["main"]["temp"]
    description = data["weather"][0]["description"]
    print(f"{name}: {temp}°C, {description}")

if __name__ == "__main__":
    main()
```

**Run it:**
```bash
python weather.py
```

Expected output:
```
San Francisco: 14.2°C, overcast clouds
```

---

## What's Happening

```
weather.py
  ↓ load_dotenv() reads .env
  ↓ API_KEY comes from the environment, not the code
  ↓ requests.get() sends HTTP GET to OpenWeather
  ↓ response.json() parses the JSON into a Python dict
  ↓ we pull out the fields we want and print them
```

---

## Introduce Claude Code

Claude Code is an AI coding assistant that runs in your terminal. It can help you extend this script, debug errors, and explain unfamiliar code.

Install it:
```bash
npm install -g @anthropic-ai/claude-code
```

Start it in the project directory:
```bash
claude
```

**Try it:** Ask Claude to extend `weather.py` to accept a city as a command-line argument. Watch what it does. Verify the result works. This is how you use it — as a collaborator, not a magic button.

---

## Commit the Project

```bash
git add weather.py requirements.txt .gitignore
git commit -m "add weather script with env-based API key"
git push
```

Notice: `.env` is not in that `git add`. Your key stays on your machine.

---

## Verify

```bash
bash modules/09-api-project/verify.sh
```

---

## What you can do now

You can talk to a service on the internet from code you wrote. You know how to keep secrets out of your code, manage dependencies, and use a virtual environment. Every API in the world uses the same pattern.

## Stretch

- Add a `--city` command-line argument using Python's `argparse` module so you can run `python weather.py --city Tokyo`
- Fetch a 5-day forecast: change the endpoint to `/data/2.5/forecast`
- Ask Claude Code to add error handling for when the city isn't found (API returns a 404)
