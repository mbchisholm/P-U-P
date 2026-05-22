# Python Projects: venv and pip

A Python script that imports a library assumes that library is installed. On a fresh machine — or someone else's machine, or a server — it isn't. Virtual environments exist to make "installed" mean something specific and reproducible.

---

## The Problem Without venv

You install `requests` with `pip3 install requests`. It goes into your system Python. Now every project on your machine shares the same package versions. Project A needs `requests==2.28`. Project B needs `requests==2.31`. They can't coexist — whichever you install last wins, and the other breaks.

Virtual environments fix this by giving each project its own isolated copy of Python and its packages.

---

## Creating and Activating a venv

```bash
cd demos/3-python

python3 -m venv .venv          # create the environment
source .venv/bin/activate      # activate it (Mac/Linux)
# .venv\Scripts\activate       # Windows

pip install requests           # installs into .venv only
python3 main.py                # runs using .venv's Python
```

Your prompt changes to `(.venv) $` when it's active. That prefix tells you which environment you're in.

When you're done:
```bash
deactivate
```

The `.venv/` folder is just a directory. Delete it and you're back to a clean slate.

---

## requirements.txt

```bash
pip freeze > requirements.txt   # capture current state
pip install -r requirements.txt  # restore it on another machine
```

`pip freeze` lists every installed package and its exact version. Committing this file means anyone who clones your repo can recreate your exact environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

This is why `.venv/` goes in `.gitignore` but `requirements.txt` gets committed. The folder is hundreds of megabytes. The text file is 10 lines.

---

## What This Script Does

```python
import requests

def get_weather(lat, lon):
    url = "https://api.open-meteo.com/v1/forecast"
    params = {"latitude": lat, "longitude": lon, "current": "temperature_2m,wind_speed_10m"}
    response = requests.get(url, params=params)
    return response.json()["current"]
```

`requests.get()` is the Python equivalent of `curl`. Pass a URL and params dict — it handles encoding, sends the request, returns a response object. `.json()` parses the body.

Same data as the bash and browser demos. Different runtime, identical result.

---

## Comparing the Three Demos

You've now seen the same weather API call in three environments:

| Context | Tool | When to use |
|---|---|---|
| Terminal | `curl \| jq` | Quick inspection, shell scripts |
| Browser | `fetch()` | User-facing interfaces |
| Python | `requests` | Automation, data pipelines, servers |

The API doesn't know or care which one is calling it. An HTTP request is an HTTP request.

---

## Hands-On

1. Create the venv, activate it, install `requests`, run `main.py`.
2. Run `pip list` inside the venv. Then deactivate and run it again. Compare.
3. Add a second function that fetches ISS position from `http://api.open-notify.org/iss-now.json` and prints latitude/longitude.
4. Run `pip freeze > requirements.txt`. Open the file — note the exact version pins.

---

## The Three Rules

1. **Every project gets its own venv.** Never install packages into system Python.
2. **Commit `requirements.txt`, not `.venv/`.** The file is reproducible; the folder is not worth committing.
3. **`source .venv/bin/activate` every time** you open a new terminal in a project. The venv doesn't activate itself.
