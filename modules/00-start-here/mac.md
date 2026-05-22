# Module 00 — macOS Setup

## Step 1 — Open Terminal

Terminal is already on your Mac. You don't need to install anything yet.

1. Press `cmd + space` to open Spotlight
2. Type `Terminal`
3. Press Enter

A window opens. You'll see a prompt ending in `%` or `$`. That's where you type commands.

**Try it:**
```bash
echo "hello"
```

You should see `hello` printed back. That's the shell responding.

---

## Step 2 — Install Homebrew

Homebrew is a package manager — it installs developer tools with a single command instead of hunting for `.dmg` files.

Paste this and press Enter:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- It will ask for your Mac password (nothing appears as you type — that's normal)
- It will ask you to press Enter to confirm
- Installation takes 2–5 minutes

> **Apple Silicon Macs (M1/M2/M3/M4):** After install, Homebrew prints two commands to add it to your PATH. Run those before continuing. You can check: Apple menu → About This Mac → chip name.

**Check:**
```bash
brew --version
```
You should see `Homebrew 4.x.x` or higher.

---

## Step 3 — Install git

git is likely already on your Mac, but let's confirm and configure it.

```bash
git --version
```

If you see a dialog asking you to install Xcode Command Line Tools — click **Install** (not "Get Xcode"). Takes 2–5 minutes.

Once git is installed, tell it who you are:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Use the email you'll use for GitHub. You'll create that account in Module 04.

**Check:**
```bash
git config --global user.name
git config --global user.email
```

Both should print back what you just set.

---

## Step 4 — Create your Developer folder

```bash
mkdir -p ~/Developer
```

This is where all your code will live. One place, always.

---

## Step 5 — Clone this repo

```bash
cd ~/Developer
git clone https://github.com/mbchisholm/P-U-P.git power-user-principles
cd power-user-principles
```

**Check:**
```bash
ls
```

You should see: `modules/  scripts/  templates/  reference/  README.md`

---

## Step 6 — Run the verify script

```bash
bash modules/00-start-here/verify.sh
```

All green? Go back to [README.md](README.md).

---

## Troubleshooting

**"command not found: brew"**
Homebrew didn't get added to your PATH. The install script prints two commands to run after installation — run those. Then open a **new** Terminal window and try again.

**"git: command not found"**
The Xcode Command Line Tools install may not have finished. Wait for it, then open a new Terminal window.

**"permission denied" on any command**
Try adding `sudo` before the command. It will ask for your password.
