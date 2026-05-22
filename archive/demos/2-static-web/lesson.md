# The Browser as a Runtime

A web page isn't just displayed content — it's a program. The browser runs JavaScript, makes network requests, and updates the DOM based on what comes back. Understanding that unlocks everything else.

---

## Open DevTools Before You Load the Page

```bash
open index.html
```

Before you do, open **DevTools → Network tab** (cmd+option+i → Network). Then load. You'll see a `forecast` request appear the moment the page loads. Click it.

- **Headers tab:** the full URL, method (GET), status (200)
- **Response tab:** the raw JSON that came back

This is the whole internet. Every website you've ever used is a collection of these. A request goes out, a response comes back, JavaScript reads it and updates what you see.

---

## How the Fetch Works

```javascript
async function fetchWeather() {
  const response = await fetch(url);
  const data = await response.json();

  document.getElementById('temp').textContent = `${data.current.temperature_2m}°C`;
}

fetchWeather();
```

`fetch()` is the browser's built-in HTTP client. It returns a Promise — you `await` it to get the response, then `await response.json()` to parse the body.

The function is called once on page load. There's no server involved — the browser talks to the API directly.

---

## No Server Required

This page is a `.html` file you double-click. It has no backend. The browser:

1. Parses the HTML
2. Runs the `<script>` block
3. Makes a `fetch()` request to an external API
4. Inserts the result into the DOM

This is how weather widgets, stock tickers, and simple dashboards work. You don't always need a server — you just need an API that allows cross-origin requests (CORS).

---

## The DOM

`document.getElementById('temp')` gets a reference to the `<div id="temp">` element. `.textContent = ...` sets what it displays.

When JavaScript runs `document.getElementById('temp').textContent = '18.5°C'`, the page updates — no reload, no server round-trip.

That's what frameworks like React and Vue are doing at their core. Just at larger scale, with more structure.

---

## What DevTools Can Show You

The Network tab isn't just for this demo. It's your first tool when something is broken or slow:

| Tab | What it's for |
|---|---|
| Network | See every request — URL, status, timing, body |
| Console | JavaScript errors and `console.log()` output |
| Elements | Live HTML/CSS you can edit in place |
| Sources | The actual JavaScript files running on the page |

Open DevTools on any website and read the Network tab for 5 minutes. You'll see the same patterns everywhere.

---

## Hands-On

1. Load the page with the Network tab open. Click the `forecast` request and read the full response JSON.
2. In the Elements tab, find the `<div class="temp">` and manually change its text. Watch the page update.
3. In the Console tab, type: `document.getElementById('temp').textContent = 'broken'`
4. Modify `index.html` to also display `weather_code` from the API response.

---

## The Three Rules

1. **DevTools Network tab first.** It shows you what the browser is actually doing, not what you think it's doing.
2. **`fetch()` is just HTTP.** Whatever curl can get, fetch can get.
3. **The DOM is live.** JavaScript doesn't reload the page — it surgically updates specific elements.
