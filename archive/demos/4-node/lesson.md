# Node.js Projects: npm and package.json

Node is JavaScript that runs outside the browser — on a server, on a Pi, in a terminal. The tooling (npm, package.json, node_modules) is the JavaScript ecosystem's answer to the same problems Python solves with pip and venv.

---

## Running It

```bash
cd demos/4-node
npm install    # reads package.json, downloads dependencies
npm start      # runs the script defined in package.json "scripts"
```

Same data as the Python and bash demos. Same API, same output, different language.

---

## package.json

```bash
cat package.json
```

```json
{
  "name": "4-node",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "axios": "^2.0.0"
  }
}
```

`package.json` is the Node equivalent of `requirements.txt` — but it also defines how to run the project (`scripts`). `npm start` just runs whatever is in `"start"`. This is why you can `npm start` any Node project without knowing what the entrypoint file is called.

---

## node_modules

```bash
du -sh node_modules
```

You'll see something like `2.1M` or larger. This folder contains every dependency — including the dependencies of your dependencies. It can grow to hundreds of megabytes for complex projects.

**Never commit `node_modules/`.** It belongs in `.gitignore`. Like Python's `.venv/`, it's reproducible from the lockfile:

```bash
rm -rf node_modules
npm install      # restores everything from package.json
```

---

## axios vs. fetch

This script uses `axios`, a popular HTTP library. The browser demo used `fetch()`, which is built into the browser but wasn't in Node until v18.

```javascript
// axios
const response = await axios.get(url, { params: { ... } });
const data = response.data;

// fetch (Node 18+)
const response = await fetch(url + '?' + new URLSearchParams({ ... }));
const data = await response.json();
```

Both make the same HTTP request. `axios` is slightly more convenient for setting params and handles JSON automatically. For simple cases in modern Node, `fetch` is fine.

---

## async/await

Both Python and JavaScript use `async/await` for network calls, but the reason is different.

Network requests take time. Rather than freezing the entire program while waiting for a response, async code says: "start this request, then come back when it's done." In Node especially, this matters — it's single-threaded. If you block, everything blocks.

```javascript
// This doesn't work — .then() hasn't resolved yet
const weather = getWeather(LAT, LON);
console.log(weather);   // prints a Promise object, not data

// This works
const weather = await getWeather(LAT, LON);
console.log(weather);   // prints the actual data
```

`await` only works inside an `async` function, or at the top level of a module.

---

## Comparing npm and pip

| | npm (Node) | pip (Python) |
|---|---|---|
| Package file | `package.json` | `requirements.txt` |
| Lock file | `package-lock.json` | (use `pip freeze`) |
| Install | `npm install` | `pip install -r requirements.txt` |
| Local packages | `node_modules/` | `.venv/` |
| Run script | `npm start` | `python3 script.py` |

Different syntax, same idea: declare what you need, install it, don't commit the installed files.

---

## Hands-On

1. Run `npm install && npm start`. Confirm it prints weather data.
2. Run `du -sh node_modules`. Then open `node_modules/` in Finder — look around.
3. Delete `node_modules/`. Run `npm install` again. It comes back.
4. Rewrite `index.js` to use the built-in `fetch()` instead of `axios`. Remove the `axios` dependency from `package.json`.

---

## The Three Rules

1. **`node_modules/` in `.gitignore`, always.** It's derived from `package.json`.
2. **`npm install` before you run any Node project you cloned.** The folder isn't committed.
3. **`async/await` for anything that hits the network.** Synchronous network calls block the process.
