import time
import threading
import requests
from flask import Flask, jsonify, request, send_from_directory
from flask_socketio import SocketIO
from flask_cors import CORS

app = Flask(__name__, static_folder="static")
CORS(app)
socketio = SocketIO(app, cors_allowed_origins="*")

# Bounding box centered on Westchester Airport (KHPN) — covers NYC metro area
BOUNDS = {
    "lamin": 39.5,
    "lamax": 42.5,
    "lomin": -76.0,
    "lomax": -71.0,
}

# In-memory message store — intentionally resets on restart
# (This is the moment to ask: "What would we need to make these survive a restart?")
messages = []


# ── Routes ────────────────────────────────────────────────────────────────────

@app.route("/")
def index():
    return send_from_directory("static", "index.html")

@app.route("/api/messages", methods=["GET"])
def get_messages():
    return jsonify(messages)

@app.route("/api/messages", methods=["POST"])
def post_message():
    data = request.get_json()
    msg = {
        "text": data.get("text", "").strip(),
        "author": data.get("author", "anon").strip() or "anon",
        "time": time.strftime("%H:%M"),
    }
    if not msg["text"]:
        return jsonify({"error": "empty message"}), 400
    messages.append(msg)
    socketio.emit("new_message", msg)
    return jsonify(msg), 201


# ── Data fetchers ─────────────────────────────────────────────────────────────

def fetch_iss():
    try:
        r = requests.get("http://api.open-notify.org/iss-now.json", timeout=5)
        pos = r.json()["iss_position"]
        return {"lat": float(pos["latitude"]), "lon": float(pos["longitude"])}
    except Exception:
        return None

def fetch_flights():
    try:
        r = requests.get(
            "https://opensky-network.org/api/states/all",
            params=BOUNDS,
            timeout=10,
        )
        states = r.json().get("states") or []
        flights = []
        for s in states:
            # s[5] = longitude, s[6] = latitude — skip if missing
            if s[5] is None or s[6] is None:
                continue
            flights.append({
                "callsign": (s[1] or "").strip(),
                "lon":       s[5],
                "lat":       s[6],
                "altitude":  s[7],    # meters
                "velocity":  s[9],    # m/s
                "heading":   s[10],   # degrees
                "on_ground": s[8],
            })
        return [f for f in flights if not f["on_ground"]]
    except Exception:
        return []


# ── Background thread — polls APIs and pushes via WebSocket ──────────────────

def background_thread():
    tick = 0
    while True:
        iss = fetch_iss()
        if iss:
            socketio.emit("iss_update", iss)

        # Fetch flights every 30 s (every 6th tick at 5 s interval)
        if tick % 6 == 0:
            flights = fetch_flights()
            socketio.emit("flight_update", flights)

        tick += 1
        time.sleep(5)

_thread = threading.Thread(target=background_thread, daemon=True)
_thread.start()


# ── Entry point ───────────────────────────────────────────────────────────────

if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=5000, debug=False)
