# Bash Pipelines

A shell script is just commands you'd type manually, saved in a file. The interesting part is how you chain them — the output of one command becomes the input of the next. That's the Unix philosophy, and it's why small tools have lasted 50 years.

---

## What This Script Does

```bash
bash pipeline.sh
```

Every run fetches live weather data, pulls two numbers out of the JSON, formats a log line, and appends it to a file. Run it five times — the file grows. That's the whole script.

The pattern you'll use forever:

```bash
RESPONSE=$(curl -s "https://some-api.com/data")
VALUE=$(echo "$RESPONSE" | jq '.some.field')
```

`$()` runs a command and captures its output into a variable. `|` pipes output from one command into the next. That's it. Everything else is just what commands you chain.

---

## curl — Fetch Anything

```bash
curl -s "https://api.open-meteo.com/v1/forecast?latitude=41.07&longitude=-73.71&current=temperature_2m"
```

`-s` means silent — no progress bar. What comes back is JSON, printed to the terminal. You can pipe it somewhere, save it, or just read it.

```bash
# Save to a file
curl -s "https://..." > response.json

# Pretty-print immediately
curl -s "https://..." | jq .
```

---

## jq — Read JSON from the Command Line

JSON is nested. `jq` gives you a way to pull specific values out without writing a script.

```bash
echo '{"current": {"temperature_2m": 18.5, "wind_speed_10m": 12.3}}' | jq '.current.temperature_2m'
# 18.5
```

Dot notation navigates the structure. `.` alone pretty-prints the whole thing.

```bash
curl -s "https://..." | jq '.'         # pretty-print
curl -s "https://..." | jq '.current'  # one key
curl -s "https://..." | jq '.current.temperature_2m'  # nested value
```

You don't need to write a Python script to inspect an API response. `curl | jq` does it in one line.

---

## Variables and Quoting

```bash
LAT="41.0670"
URL="https://api.open-meteo.com/v1/forecast?latitude=${LAT}"
```

Always quote variables in double quotes when you use them. If the value ever contains a space, unquoted expansion breaks things in ways that are hard to debug.

```bash
# Fragile
echo $ENTRY

# Safe
echo "$ENTRY"
```

---

## Appending vs Overwriting

```bash
echo "data" > file.txt    # overwrites
echo "data" >> file.txt   # appends
```

`>` truncates the file first. `>>` adds to the end. The pipeline uses `>>` so each run stacks on the previous log. If you accidentally use `>`, you lose the history.

---

## The Loop (Commented Out)

At the bottom of the script:

```bash
# while true; do
#   ...
#   sleep 10
# done
```

Uncomment it and you have a daemon — a process that runs forever, doing the same thing on a timer. This is the pattern behind cron jobs, log shippers, health checks, and monitoring agents.

The only difference between a script and a service is the loop.

---

## Hands-On

1. Run `bash pipeline.sh` three times. Open `weather_log.txt` and read it.
2. Modify the script to also log `weather_code` from the API response.
3. Uncomment the loop. Watch it run. Kill it with `ctrl+c`.
4. Write a new script that fetches the ISS position from `http://api.open-notify.org/iss-now.json` and logs latitude and longitude.

---

## The Three Rules

1. **`curl | jq`** gets you any API data in one line. Reach for it before writing a script.
2. **Quote your variables.** Unquoted expansion is a common source of weird bugs.
3. **`>>` to append, `>` to overwrite.** Know which one you mean.
