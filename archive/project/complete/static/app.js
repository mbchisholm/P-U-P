// ── Globe setup ───────────────────────────────────────────────────────────────

const globe = Globe()
  .globeImageUrl("//unpkg.com/three-globe/example/img/earth-night.jpg")
  .backgroundImageUrl("//unpkg.com/three-globe/example/img/night-sky.png")
  .width(window.innerWidth - 300)
  .height(window.innerHeight)
  (document.getElementById("globe-container"));

// Center on NYC / Westchester
globe.pointOfView({ lat: 41.0, lng: -73.7, altitude: 0.5 }, 1000);

window.addEventListener("resize", () => {
  globe.width(window.innerWidth - 300).height(window.innerHeight);
});


// ── State ─────────────────────────────────────────────────────────────────────

let flightData = [];
let issData    = [];


// ── Marker renderer ───────────────────────────────────────────────────────────

function renderMarkers() {
  const allMarkers = [
    ...flightData.map(f => ({ ...f, _type: "flight" })),
    ...issData.map(p  => ({ ...p, _type: "iss"    })),
  ];

  globe
    .htmlElementsData(allMarkers)
    .htmlLat("lat")
    .htmlLng("lon")
    .htmlElement(d => {
      const el = document.createElement("div");
      el.style.userSelect = "none";

      if (d._type === "iss") {
        el.style.fontSize  = "22px";
        el.style.cursor    = "default";
        el.title           = "International Space Station";
        el.textContent     = "🛸";
        document.getElementById("iss-status").textContent =
          `ISS: ${d.lat.toFixed(2)}°, ${d.lon.toFixed(2)}°`;
        return el;
      }

      // Flight marker — rotate emoji to match heading
      el.style.fontSize   = "14px";
      el.style.color      = "#4a9eff";
      el.style.transform  = `rotate(${(d.heading || 0)}deg)`;
      el.style.cursor     = "pointer";
      el.textContent      = "✈";

      const altFt  = Math.round((d.altitude  || 0) * 3.28084);
      const spdKts = Math.round((d.velocity  || 0) * 1.944);
      el.title = [
        d.callsign || "UNKNOWN",
        `Alt: ${altFt.toLocaleString()} ft`,
        `Spd: ${spdKts} kts`,
        `Hdg: ${Math.round(d.heading || 0)}°`,
      ].join(" · ");

      return el;
    });
}


// ── WebSocket listeners ───────────────────────────────────────────────────────

const socket = io();

socket.on("flight_update", flights => {
  flightData = flights;
  renderMarkers();
});

socket.on("iss_update", pos => {
  issData = [pos];
  renderMarkers();
});

socket.on("new_message", msg => appendMessage(msg));


// ── Message board ─────────────────────────────────────────────────────────────

function appendMessage(msg) {
  const div = document.createElement("div");
  div.className = "message";
  div.innerHTML = `
    <span class="msg-author">${escapeHtml(msg.author)}</span>
    <span class="msg-time">${msg.time}</span>
    <span class="msg-text">${escapeHtml(msg.text)}</span>
  `;
  const container = document.getElementById("messages");
  container.appendChild(div);
  container.scrollTop = container.scrollHeight;
}

function escapeHtml(str) {
  return String(str)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

// Load messages that arrived before this client connected
fetch("/api/messages")
  .then(r => r.json())
  .then(msgs => msgs.forEach(appendMessage));

document.getElementById("message-form").addEventListener("submit", e => {
  e.preventDefault();
  const author = document.getElementById("author-input").value.trim() || "anon";
  const text   = document.getElementById("message-input").value.trim();
  if (!text) return;

  fetch("/api/messages", {
    method:  "POST",
    headers: { "Content-Type": "application/json" },
    body:    JSON.stringify({ author, text }),
  });

  document.getElementById("message-input").value = "";
});
