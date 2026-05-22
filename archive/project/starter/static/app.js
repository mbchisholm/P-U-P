// ── TODO 7 ───────────────────────────────────────────────────────────────────
// Initialize the Globe.
//
// Globe() is a function from globe.gl (already loaded in index.html).
// Chain these methods on it, then call it with the container element:
//
//   .globeImageUrl("//unpkg.com/three-globe/example/img/earth-night.jpg")
//   .backgroundImageUrl("//unpkg.com/three-globe/example/img/night-sky.png")
//   .width(window.innerWidth - 300)
//   .height(window.innerHeight)
//   (document.getElementById("globe-container"))
//
// Then point the camera at NYC:
//   globe.pointOfView({ lat: 41.0, lng: -73.7, altitude: 0.5 }, 1000)
//
// globe.gl docs: https://github.com/vasturiano/globe.gl

let globe; // assign your Globe instance here


// ── State ─────────────────────────────────────────────────────────────────────

let flightData = [];
let issData    = [];


// ── TODO 8 ───────────────────────────────────────────────────────────────────
// Write renderMarkers().
//
// Combine flightData and issData into one array (add a "_type" property to
// each so you can tell them apart). Then call:
//
//   globe.htmlElementsData(allMarkers)
//        .htmlLat("lat")
//        .htmlLng("lon")
//        .htmlElement(d => { ... })
//
// For each marker, create a <div> element:
//   - ISS:    emoji "🛸", fontSize 22px, update #iss-status text
//   - Flight: emoji "✈", fontSize 14px, color #4a9eff,
//             rotate to heading with transform: `rotate(${d.heading}deg)`
//             set .title to callsign + altitude + speed
//
// Helper: altitude in feet = meters * 3.28084
//         speed in knots   = m/s   * 1.944

function renderMarkers() {
  // your code here
}


// ── WebSocket listeners ───────────────────────────────────────────────────────

const socket = io();

// ── TODO 9 ───────────────────────────────────────────────────────────────────
// Listen for "flight_update" and "iss_update" socket events.
// When each fires, update the corresponding state array and call renderMarkers().
//
// socket.on("event_name", data => { ... })


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
    .replace(/&/g, "&amp;").replace(/</g, "&lt;")
    .replace(/>/g, "&gt;").replace(/"/g, "&quot;");
}

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
