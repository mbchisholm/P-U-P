#!/bin/bash
# Fetch current weather for NYC and log it to a file.
# Run it multiple times — watch the log grow.
# Usage: bash pipeline.sh

LAT="41.0670"
LON="-73.7076"
LOG="weather_log.txt"

echo "Fetching weather..."

RESPONSE=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,wind_speed_10m,weather_code")

TEMP=$(echo "$RESPONSE" | jq '.current.temperature_2m')
WIND=$(echo "$RESPONSE" | jq '.current.wind_speed_10m')

ENTRY="$(date '+%Y-%m-%d %H:%M:%S') | Temp: ${TEMP}°C | Wind: ${WIND} km/h"
echo "$ENTRY" >> "$LOG"

echo "Logged: $ENTRY"
echo ""
echo "Full log:"
cat "$LOG"

# ---------- BONUS: run as a loop (uncomment to try) ----------
# while true; do
#   RESPONSE=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,wind_speed_10m")
#   TEMP=$(echo "$RESPONSE" | jq '.current.temperature_2m')
#   echo "$(date '+%H:%M:%S') | ${TEMP}°C" >> "$LOG"
#   echo "Logged ${TEMP}°C"
#   sleep 10
# done
