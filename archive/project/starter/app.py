import time
import threading
import requests
from flask import Flask, jsonify, request, send_from_directory
from flask_socketio import SocketIO
from flask_cors import CORS

app = Flask(__name__, static_folder="static")
CORS(app)
socketio = SocketIO(app, cors_allowed_origins="*")

# Bounding box centered on Westchester Airport (KHPN)
BOUNDS = {
    "lamin": 39.5,
    "lamax": 42.5,
    "lomin": -76.0,
    "lomax": -71.0,
}

messages = []


# ── TODO 1 ────────────────────────────────────────────────────────────────────
# Add the index route so visiting "/" in a browser serves our HTML page.
# Flask docs: https://flask.palletsprojects.com/en/3.0.x/api/#flask.send_from_directory
#
# @app.route("/")
# def index():
#     return ...


# ── TODO 2 ────────────────────────────────────────────────────────────────────
# Add two message routes:
#   GET  /api/messages  → return the messages list as JSON
#   POST /api/messages  → read JSON body, build a message dict with "text",
#                         "author", and "time" (use time.strftime("%H:%M")),
#                         append to messages, emit a "new_message" socket event,
#                         and return the new message with status 201.
#
# Hint: request.get_json() reads the POST body.
# Flask docs: https://flask.palletsprojects.com/en/3.0.x/api/#flask.Request.get_json


# ── TODO 3 ────────────────────────────────────────────────────────────────────
# Write fetch_iss() — call the ISS position API and return a dict:
#   {"lat": <float>, "lon": <float>}
#
# API (no key needed): http://api.open-notify.org/iss-now.json
# Wrap in try/except and return None on failure.
#
def fetch_iss():
    pass  # replace this


# ── TODO 4 ────────────────────────────────────────────────────────────────────
# Write fetch_flights() — call the OpenSky API with BOUNDS and return a list
# of flight dicts. Each dict should have:
#   callsign, lon, lat, altitude, velocity, heading, on_ground
#
# API: https://opensky-network.org/api/states/all
# The response has a "states" list. Each state is an array — indices:
#   [1]=callsign [5]=lon [6]=lat [7]=altitude [8]=on_ground [9]=velocity [10]=heading
#
# Skip states where lon or lat is None. Filter out on_ground flights.
#
def fetch_flights():
    return []  # replace this


# ── Background thread ─────────────────────────────────────────────────────────
# This runs continuously in the background, polling the APIs and pushing
# updates to all connected browsers via WebSocket.

def background_thread():
    tick = 0
    while True:
        # ── TODO 5 ────────────────────────────────────────────────────────────
        # Call fetch_iss(). If it returns a result (not None),
        # emit an "iss_update" socket event with the position dict.
        #
        # socketio.emit("iss_update", <data>)

        # Fetch flights every 30 s (every 6th tick)
        if tick % 6 == 0:
            # ── TODO 6 ────────────────────────────────────────────────────────
            # Call fetch_flights() and emit a "flight_update" socket event
            # with the list of flights.
            pass

        tick += 1
        time.sleep(5)

_thread = threading.Thread(target=background_thread, daemon=True)
_thread.start()


if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=5000, debug=False)
