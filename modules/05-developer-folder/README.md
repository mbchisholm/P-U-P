# Module 05 — The Developer Folder

> **You'll be able to:** Set up a consistent home for all your code and explain why structure matters.
> **Time:** ~20 min
> **Prereqs:** Module 02

## Why this matters

Code is files. Files live in directories. If you don't pick a place intentionally, you'll find projects scattered across Downloads, Desktop, and random folders you can't find six months later. One convention, followed consistently, means you always know where things are.

## Setup

```bash
cd ~
```

---

## The Convention

```
~/Developer/
├── <org-or-username>/
│   ├── <repo-name>/
│   └── <another-repo>/
└── personal/
    └── <personal-project>/
```

Examples:
```
~/Developer/TrellisLabs/power-user-principles/
~/Developer/stripe/stripe-python/
~/Developer/personal/dotfiles/
```

The structure mirrors where code lives on GitHub: `github.com/org/repo` → `~/Developer/org/repo`. When you `cd` into it from the terminal, the path tells you exactly what project you're in and who owns it.

---

## Set It Up

```bash
mkdir -p ~/Developer
```

If you followed Module 00, this already exists. That's fine.

For a project you're about to clone:

```bash
mkdir -p ~/Developer/TrellisLabs
cd ~/Developer/TrellisLabs
git clone git@github.com:TrellisLabs/power-user-principles.git
```

---

## Navigating Quickly

```bash
cd ~/Developer                    # always works, from anywhere
ls ~/Developer                    # see all orgs/projects at a glance
```

Add this to your shell config later (Module 07) and you can get there with a single alias:

```bash
alias dev="cd ~/Developer"
```

---

## Why Not Desktop or Downloads?

- **Desktop** — visible clutter, syncs to iCloud (or OneDrive), creates surprise behavior
- **Downloads** — gets cleaned. Your code should not be in the same place as zip files you'll delete
- **Home (`~`) directly** — fine for dotfiles, not for projects. Projects grow into many files.

`~/Developer` is one level of indirection that costs nothing and solves all of these.

---

## Verify

```bash
bash modules/05-developer-folder/verify.sh
```

---

## What you can do now

You have a permanent, predictable home for code. Every project from here on lives in `~/Developer/<org>/<repo>`.

## Stretch

- Create subdirectories for any orgs you already work with: `mkdir -p ~/Developer/personal`
- Run `ls -la ~/Developer` — what's already there?
