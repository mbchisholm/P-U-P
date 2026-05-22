# Instructor Notes — Power User Principles

## Before the day

- [ ] Flash Pi Zero 2W with Raspberry Pi OS Lite (64-bit) using Raspberry Pi Imager
  - Advanced settings: set hostname `workshop.local`, enable SSH, configure WiFi
  - Username: `pi`, set a simple password
- [ ] Boot the Pi at the venue, confirm `ssh pi@workshop.local` works
- [ ] Test venue WiFi allows device-to-device traffic (some corporate networks block it)
- [ ] Run `bash setup.sh` on a clean machine to verify it works
- [ ] Push your completed project to GitHub so students can clone it in Part 5
- [ ] Open `project/complete/` and confirm it runs end-to-end before the day

---

## Part 1 — File System & Shell (~45 min)

**Open with:** "Your computer has a brain and a memory. Finder is a pretty picture of
the memory. We're going to talk to it directly."

Walk through the file tree on a whiteboard first. Then open Terminal.

Key commands in order: `pwd` → `ls` → `ls -la` → `cd` → `mkdir` → `touch` →
`echo "..." > file` → `cat` → `mv` → `cp` → `rm`

**Teach tab completion aggressively.** Type the first two letters of everything and
hit Tab. It's a quality-of-life shift that sticks immediately.

**Introduce pipes last:**
```bash
ls -la | grep ".txt"
history | tail -20
```
Say: "The output of one command becomes the input of the next. This is the Unix
philosophy — small tools that do one thing, chained together."

**Close Part 1 with:** "Everything Finder does, you just did faster. Now let's look
at what people actually build."

---

## Part 2 — Lay of the Land (~60 min)

Goal: pattern recognition, not depth. Students should leave knowing what a project
looks like before they open it.

### Demo 1 — Bash (`demos/1-bash-pipeline/`)
```bash
bash pipeline.sh
```
Show the log file grow. Then show the commented-out loop — "this is a daemon."
Teach: piping, variables, `jq` as a tool you borrow.

### Demo 2 — Static Web (`demos/2-static-web/`)
```bash
open index.html
```
**Open DevTools → Network tab before loading.** Watch the `fetch()` request appear.
Click it. Show the Request and Response. Say: "This is the whole internet. A request
and a response."

### Demo 3 — Python (`demos/3-python/`)
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install requests
python3 main.py
```
Teach `venv` and `pip`. Show `requirements.txt`. Compare output to Demo 2 — same
data, different context.

### Demo 4 — Node (`demos/4-node/`)
```bash
npm install
npm start
```
Point out `package.json` vs `requirements.txt`. Show `node_modules` size with
`du -sh node_modules`. Foreshadow `.gitignore`.

### Demo 5 — Landing Page (`demos/5-landing-page/`)
```bash
open index.html
```
Just show it. Let the room react. Then open DevTools, highlight the animated gradient
CSS. "40 lines of CSS. That's it."

**This is a good moment to say:** "Code can be a craft. People make careers out of
this specifically."

### Demo 6 — Generative Art (`demos/6-generative-art/`)
```bash
open index.html
```
After the room reacts, open `sketch.js` in VSCode. Change `NOISE_SCALE` from
`0.0022` to `0.008`. Save. Reload. "Same code, one number changed."

Then change `STROKE_COLOR` to `[255, 100, 80]`. Reload.

Say: "This same math generates terrain in video games, smoke in Pixar films, and
risk models on Wall Street."

Show openprocessing.org briefly — "this is what people build with this."

**Transition:** "You've seen what projects look like. Now let's build one."

---

## Part 3 — VSCode + The Project (~90 min)

Students work from `project/starter/`. The venv is already created by `setup.sh`.

```bash
cd project/starter
source .venv/bin/activate
```

Build in stages, each ending in a working state:

**Stage 1 — TODO 1 (the index route)**
After completing: `python3 app.py` → `localhost:5000` in the browser.
**Wow #1:** "Now type my IP address on your phone."
Find your IP: `ipconfig getifaddr en0` (Mac Wi-Fi)

**Stage 2 — TODO 2 (message routes)**
After completing: open `/api/messages` directly in the browser to see `[]`.
Post a message with curl or the form. Reload `/api/messages` and see it in JSON.
"This is an API. You just built one."

**Stage 3 — TODOs 3 + 4 (fetch_iss and fetch_flights)**
After completing: open `/api/flights` in the browser. The JSON contains real planes.
"Those are actual flights. Right now. Over Westchester."

**Stage 4 — TODOs 5 + 6 (background thread)**
After completing: WebSocket is pushing data. Open the browser console (DevTools) and
show the socket events arriving. Students can see the raw events before the globe renders them.

**Stage 5 — TODOs 7 + 8 (globe + markers)**
After completing: the globe appears. Then flight markers populate.
**Wow #2:** Pause. Let people look. If it's nighttime you can see city lights.

**Stage 6 — TODO 9 (socket listeners)**
After completing: markers update in real time without a page refresh.
Tell everyone to open the message form and post their name. Watch messages appear
on everyone's screen simultaneously.
**Wow #3:** "That's basically how every chat app, social feed, and multiplayer game works."

**Close Part 3 with the database moment:**
Restart the server (`ctrl+c`, `python3 app.py`). Messages are gone.
"So what would we need to make those survive? That's what a database is."

---

## Part 4 — GitHub (~45 min)

Use `project/starter/` as the repo students push.

```bash
git init
git status
```

**Draw the three states on a whiteboard:** working directory → staging area → commit.
"A commit is a permanent snapshot. Not a save. A save overwrites. A commit stacks."

```bash
touch .gitignore    # already exists, just show it
git add .
git commit -m "initial commit: live flight dashboard"
git log --oneline
```

Make a visible change (change the page title in index.html). Show `git diff`.
Commit again. Show `git log --oneline` — two commits.

Push to GitHub. Show the repo online. Show commit history. Show the blame view on one file.

**Close Part 4 with:** "Now the Pi can just pull this. We don't have to copy files manually."

---

## Part 5 — Networking + Pi (~60 min)

### SSH In

```bash
ssh pi@workshop.local
```

Let the silence sit for a moment. Then: "You're controlling a computer in this room.
No screen. No keyboard. No mouse. Just text."

Walk around the file system. `ls`, `pwd`, `cd`. "Linux is Linux. Same commands,
whether it's a Raspberry Pi, an AWS server, or a Google data center."

### Network scan

```bash
bash scan.sh
```

Devices appear. Someone recognizes their phone. "Every device on this WiFi has an
address. This is how network engineers see a room."

**This is the networking concept made physical.** You can talk about subnets, ARP,
and MAC addresses here with something concrete to point at.

### Deploy

```bash
bash setup.sh     # installs deps, clones repo
cd workshop-project/project/starter
source .venv/bin/activate
python3 app.py
```

From any device in the room: `http://workshop.local:5000`

**Wow #4:** Their project — built from scratch today — is running on a $15 chip, 
accessible from any phone in the room, with no laptop open.

### Close the loop (20 min discussion)

| What we did | What it maps to |
|---|---|
| Flask on the Pi | An app on AWS / Heroku / a VPS |
| `git clone` to deploy | GitHub Actions, CI/CD pipelines |
| `workshop.local` | DNS — just a name for an IP address |
| Port 5000 | Port 443 (HTTPS) — add a domain and a cert |
| In-memory messages | A real database (Postgres, SQLite, Redis) |
| One Pi, one app | Containers, Kubernetes, horizontal scaling |

"Every website you've ever used is this. With more layers. You now understand
every layer."

---

## Fallback plan

If the Pi doesn't work (network issue, SD card failure):
- Demo the SSH portion using `localhost` — `ssh localhost` still teaches the concepts
- The project still runs on student laptops and is accessible via laptop IP on WiFi
- Keep a flashed backup SD card

If OpenSky rate-limits (they occasionally throttle anonymous requests):
- The ISS tracker still works (different API)
- The message board still works
- Explain rate limiting as a teaching moment: "This is why APIs have keys and pricing"
