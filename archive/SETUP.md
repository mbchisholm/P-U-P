# Pre-Workshop Setup Guide

Complete these steps **before the workshop day**. Everything here is free.
If something doesn't work, reach out in advance — troubleshooting installs
during the session eats into building time.

Expected time: **30–45 minutes**

---

## What you're installing and why

| Tool | What it is |
|---|---|
| **Homebrew** | A package manager for Mac — like an App Store for developer tools |
| **Python 3.11** | The programming language we'll write our app in |
| **Node.js** | A JavaScript runtime — lets you run JS outside the browser |
| **git** | Version control — how you save and share code |
| **VSCode** | The code editor we'll use |
| **jq** | A command-line tool for reading JSON |
| **nmap** | A network scanner we'll use in Part 5 |
| **GitHub account** | Where your code lives online |

---

## Step 1 — Open Terminal

Terminal is a text-based way to control your computer. You'll use it throughout
the workshop.

**On Mac:**
1. Press `cmd + space` to open Spotlight
2. Type `Terminal`
3. Press Enter

A window opens with a prompt that ends in `$`. That's where you type commands.

> **Note for Windows users:** Use Windows Terminal or PowerShell. Some commands
> below will differ — your instructor will help with those during the workshop.

---

## Step 2 — Install Homebrew

Homebrew is a package manager — it lets you install developer tools with a
single command instead of hunting for installers.

Paste this into Terminal and press Enter:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- It will ask for your Mac password (nothing appears as you type — that's normal)
- It will ask you to press Enter to confirm
- Installation takes 2–5 minutes

**Verify it worked:**
```bash
brew --version
```
You should see something like `Homebrew 4.x.x`.

> **Apple Silicon Macs (M1/M2/M3):** After install, Homebrew will print a message
> asking you to run two more commands to add it to your PATH. Run those before
> continuing. You can tell if you have Apple Silicon by going to
> Apple menu → About This Mac — it will say "Apple M1" or similar.

---

## Step 3 — Install Python 3.11

Mac comes with an older Python. We need 3.11.

```bash
brew install python@3.11
```

This takes 1–3 minutes.

**Verify it worked:**
```bash
python3 --version
```
You should see `Python 3.11.x`.

**Also verify pip (Python's package installer):**
```bash
pip3 --version
```
You should see a version number.

---

## Step 4 — Install Node.js

Node lets JavaScript run outside the browser. We use it in one of the demos.

```bash
brew install node
```

**Verify it worked:**
```bash
node --version
npm --version
```
Both should print version numbers (`v18.x.x` or higher for Node).

---

## Step 5 — Install git

git is version control software — it tracks every change you make to your code.
It may already be installed.

```bash
git --version
```

If you see `git version 2.x.x` — you're done, skip to Step 6.

If you see an error or a dialog asking you to install Xcode Command Line Tools:

```bash
xcode-select --install
```

A dialog will appear — click **Install** (not "Get Xcode"). Takes 2–5 minutes.

**Configure git with your name and email** — this tags your commits:
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Use the same email you'll use for your GitHub account (Step 8).

---

## Step 6 — Install jq and nmap

Two small tools used in the workshop demos.

```bash
brew install jq nmap
```

**Verify:**
```bash
jq --version
nmap --version
```

---

## Step 7 — Install VSCode

VSCode is the code editor we'll use throughout the workshop.

1. Go to **https://code.visualstudio.com** and click **Download for Mac**
2. Open the downloaded `.zip` — it extracts to `Visual Studio Code.app`
3. Drag `Visual Studio Code.app` to your **Applications** folder
4. Open it from Applications

**Install the Shell Command** so you can open VSCode from Terminal:
1. In VSCode, press `cmd + shift + p` to open the Command Palette
2. Type `shell command`
3. Click **Shell Command: Install 'code' command in PATH**

**Verify it worked:**
```bash
code --version
```

**Install these extensions** (open VSCode, press `cmd + shift + x` to open Extensions):
- `Python` (by Microsoft)
- `Prettier - Code formatter` (by Prettier)
- `GitLens` (by GitKraken)

---

## Step 8 — Create a GitHub account

GitHub is where your code lives online. You'll push your project here in Part 4,
and the Raspberry Pi will pull from it in Part 5.

1. Go to **https://github.com** and click **Sign up**
2. Choose a username — this is public and shows on your work, pick something you like
3. Verify your email address

---

## Step 9 — Clone the workshop repo

Now grab the workshop files onto your laptop.

```bash
cd ~
mkdir Developer
cd Developer
git clone https://github.com/YOUR_INSTRUCTOR/power-user-principles.git
cd power-user-principles
```

> Your instructor will share the actual repo URL before the workshop.

---

## Step 10 — Run the setup checker

The repo includes a script that verifies everything above is in place.

```bash
bash setup.sh
```

You should see all green checkmarks:

```
Power User Principles — Setup Check
======================================

Python
  ✓ python3 installed
  ✓ python3 >= 3.11
  ✓ pip3 installed

Node / npm
  ✓ node installed
  ✓ node >= 18
  ✓ npm installed

Tools
  ✓ git installed
  ✓ curl installed
  ✓ jq installed
  ✓ nmap installed

Git config
  ✓ git user.name set
  ✓ git user.email set

Project
  ✓ venv created and dependencies installed

======================================
  13 passed  ·  0 failed

You're good to go.
```

If anything shows ✗, re-read the step for that tool above and try again.
If you're stuck, message your instructor with the exact error text.

---

## Troubleshooting

**"command not found: brew"**
Homebrew didn't get added to your PATH. On Apple Silicon Macs, the install
script prints two commands to run after installation — run those. Then open
a new Terminal window and try again.

**"python3: command not found" after brew install**
Run `brew link python@3.11` then open a new Terminal window.

**VSCode opens but extensions won't install**
Check your internet connection. If on a corporate network, try a personal hotspot.

**"permission denied" on any command**
Try adding `sudo` before the command. It will ask for your password.

**setup.sh says "git user.name set" is failing**
Run the two `git config` commands in Step 5 with your actual name and email.

---

## All set

Once `setup.sh` shows all green, you're ready. See you at the workshop.
