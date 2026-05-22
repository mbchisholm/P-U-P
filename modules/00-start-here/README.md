# Module 00 — Start Here

> **You'll be able to:** Open a terminal, clone this repo, and confirm your machine is ready to work.
> **Time:** ~30–60 min depending on your OS
> **Prereqs:** None

## Why this matters

Every tool in this curriculum runs in the terminal. Before anything else can happen, you need a shell that works. This module gets you there — nothing installed before you start, nothing assumed. You will do every step yourself, which means you'll understand what you've got when it's done.

## Setup

Nothing to do yet. This is the first module.

Pick your OS and follow that path. After this module, both paths converge.

---

## Your OS

### macOS → [mac.md](mac.md)

### Windows → [windows.md](windows.md)

---

After you've finished your OS-specific setup, come back here.

---

## Clone this repo

If you haven't already cloned this repo (the Mac path does this for you), do it now:

```bash
cd ~/Developer
git clone https://github.com/mbchisholm/P-U-P.git power-user-principles
cd power-user-principles
```

**Try it:** Run `ls`. You should see the module folders.

```
modules/   scripts/   templates/   reference/   README.md
```

---

## Verify

Run the verify script for this module:

```bash
bash modules/00-start-here/verify.sh
```

Expected output: all green checkmarks. If anything shows ✗, re-read the relevant step in your OS-specific file and try again.

---

## What you can do now

You have a working bash shell, Homebrew (Mac) or WSL (Windows), git, and a cloned copy of this repo. That's the foundation everything else builds on.

## Stretch

- Run `echo $SHELL`. It tells you which shell you're in. You should see `/bin/zsh` (Mac) or `/bin/bash` (WSL).
- Run `uname -a`. What does the output tell you?
- Run `git log --oneline` inside the repo. What do you see?
