# Module 00 — Start Here

> **You'll be able to:** Open a terminal, clone this repo, and confirm your machine is ready to work.
> **Time:** ~30–60 min depending on your OS
> **Prereqs:** None

## Why this matters

Every tool in this curriculum runs in the terminal. Before anything else can happen, you need a shell that works. This module gets you there — nothing installed before you start, nothing assumed. You will do every step yourself, which means you'll understand what you've got when it's done.

## Setup

Nothing to do yet. This is the first module. Pick your OS, follow that path, then come back here to clone the repo and run the verify script. After this module both paths converge — every later module is the same on Mac and WSL.

- **macOS →** [mac.md](mac.md)
- **Windows →** [windows.md](windows.md)

## Clone this repo

The Mac path clones it for you. If you're on Windows (WSL) or skipped that step, do it now:

```bash
cd ~/Developer
git clone https://github.com/mbchisholm/P-U-P.git power-user-principles
cd power-user-principles
```

**Try it:** Run `ls`. You should see the top-level folders:

```
modules/   scripts/   templates/   reference/   README.md
```

## Verify

```bash
bash modules/00-start-here/verify.sh
```

Expected output: all green checkmarks. If anything shows ✗, re-read the relevant step in your OS-specific file and try again.

## What you can do now

You have a working bash shell, Homebrew (Mac) or WSL (Windows), git, and a cloned copy of this repo. That's the foundation everything else builds on.

## Stretch

- Run `echo $SHELL`. It tells you which shell you're in — `/bin/zsh` on Mac, `/bin/bash` on WSL.
- Run `uname -a`. What does each piece of the output mean?
- Run `git log --oneline` inside the repo. What do you see?
