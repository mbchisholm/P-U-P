#!/bin/bash
# Pipes demo — fetch live weather data, extract two values, append to a log file.
#
# Run it: bash modules/02-filesystem/demo/pipeline.sh
# Run it again — watch the log grow.
#
# What to pay attention to:
#   $()  — run a command and capture its output as a string
#   |    — pipe the output of one command into the next
#   >>   — append to a file (vs > which overwrites)

LAT="40.7128"
LON="-74.0060"
LOG="weather_log.txt"

echo "Fetching weather for New York City..."

RESPONSE=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,wind_speed_10m")

TEMP=$(echo "$RESPONSE" | grep -o '"temperature_2m":[0-9.-]*' | grep -o '[0-9.-]*$')
WIND=$(echo "$RESPONSE" | grep -o '"wind_speed_10m":[0-9.-]*' | grep -o '[0-9.-]*$')

ENTRY="$(date '+%Y-%m-%d %H:%M:%S') | Temp: ${TEMP}°C | Wind: ${WIND} km/h"
echo "$ENTRY" >> "$LOG"

echo "Logged: $ENTRY"
echo ""
echo "Full log ($(wc -l < "$LOG") entries):"
cat "$LOG"
