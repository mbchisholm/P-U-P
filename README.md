# Power User Principles

A self-paced curriculum that takes a complete beginner from "I've never opened a terminal" to "I can SSH into my Raspberry Pi, hit an API, and ship code from VS Code."

**No prior experience required. Mac and Windows supported (WSL2).**

---

## Why

The command line isn't a relic. It's the substrate of everything — every cloud provider, every CI/CD pipeline, every server in production runs on text commands. Finder and the GUI tools you've used your whole life are *skins*. Once you can work without the skin, you can work anywhere.

This curriculum teaches the substrate.

---

## Start

**[→ Module 00: Start Here](modules/00-start-here/README.md)** — get a working terminal and clone this repo. It's the only required first step. Everything else follows from there.

---

## The 12 modules

| # | Module | You'll be able to say… | Time | Prereqs |
|---|--------|------------------------|------|---------|
| 00 | [Start Here](modules/00-start-here/README.md) | "My machine is ready. I cloned this repo." | 30–60 min | — |
| 01 | [The Terminal & The Shell](modules/01-terminal-and-shell/README.md) | "A shell is a program that runs other programs." | 30 min | 00 |
| 02 | [The File System Is a Tree](modules/02-filesystem/README.md) | "I can navigate, create, and destroy from text." | 45 min | 01 |
| 03 | [Processes, Permissions, Networks](modules/03-processes-permissions/README.md) | "Programs are processes. Files have owners. My machine has an IP." | 45 min | 02 |
| 04 | [SSH Keys & GitHub](modules/04-ssh-and-github/README.md) | "I have an identity online and a key that proves it." | 45 min | 02 |
| 05 | [The Developer Folder](modules/05-developer-folder/README.md) | "Code lives in a place. My place has a structure." | 20 min | 02 |
| 06 | [Tooling: Python, Node, Git](modules/06-tooling-installs/README.md) | "I have the languages and tools real projects need." | 45 min | 00 |
| 07 | [Terminal & Editor Config](modules/07-terminal-config/README.md) | "My terminal works the way my brain works." | 30 min | 01 |
| 08 | [IDE & Git Workflow](modules/08-ide-and-git/README.md) | "I can clone, edit, commit, and push." | 60 min | 04, 05, 06 |
| 09 | [Hitting an API](modules/09-api-project/README.md) | "I can talk to a service on the internet from code I wrote." | 60 min | 06, 08 |
| 10 | [A Tiny Database](modules/10-database-project/README.md) | "I can persist data and read it back later." | 60 min | 08 |
| 11 | [SSH Into a Pi](modules/11-pi-ssh/README.md) *(optional)* | "I can run a program on a computer that's not in front of me." | 45 min | 04 |

Work through them in order or jump to a topic. **Prereqs** tell you what to do first.

---

## How a module works

Every module follows the same shape:

1. **Why this matters** — one paragraph framing the concept
2. **Walkthrough** — concept → command → "Try it" block, repeated
3. **Follow-along demo** *(some modules)* — a runnable script in `demo/` you can read, modify, and break
4. **Verify** — `bash modules/<NN>/verify.sh` prints green checkmarks or tells you what's missing
5. **What you can do now** — concrete payoff statement
6. **Stretch** — optional deeper exercises

To check your whole environment at once:

```bash
bash scripts/verify-env.sh
```

---

## Repo layout

```
modules/      the 12 lessons (each with README, demo scripts, verify.sh)
scripts/      install-mac.sh, install-wsl.sh, verify-env.sh
templates/    project starters → see templates/README.md
reference/    cheat sheets: shell, git, keyboard shortcuts
archive/      old live-workshop material, kept for reference
```

---

## Quick reference

- **[Shell commands](reference/shell-quick-ref.md)** — pwd, ls, cd, pipes, find/grep, processes, networking
- **[Git workflow](reference/git-quick-ref.md)** — the core loop, branches, undoing, commit conventions
- **[Keyboard shortcuts](reference/shortcuts.md)** — terminal, VS Code, common chords

---

## License & contributing

This is a personal, open educational project. Feedback and issues welcome — open one on GitHub if a step doesn't work or a concept didn't land.
