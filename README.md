# Power User Principles

A self-paced curriculum that takes a complete beginner from "I've never opened a terminal" to "I can SSH into my Raspberry Pi, hit an API, and ship code from VS Code."

**No prior experience required. Mac and Windows supported.**

---

## Start Here

**[→ Module 00: Start Here](modules/00-start-here/README.md)**

Module 00 is the only required starting point. It walks you through getting a working terminal and cloning this repo. Everything else follows from there.

---

## The Modules

| # | Module | What it proves | Time | Prereqs |
|---|--------|---------------|------|---------|
| [00](modules/00-start-here/README.md) | Start Here | "My machine is ready. I have a terminal and I cloned this repo." | 30–60 min | none |
| [01](modules/01-terminal-and-shell/README.md) | The Terminal & The Shell | "A shell is a program that takes text and runs it." | 30 min | 00 |
| [02](modules/02-filesystem/README.md) | The File System Is a Tree | "Finder is a skin. I can navigate, create, and destroy from text." | 45 min | 01 |
| [03](modules/03-processes-permissions/README.md) | Processes, Permissions, Networks | "Programs are processes. Files have owners. My machine has an IP." | 45 min | 02 |
| [04](modules/04-ssh-and-github/README.md) | SSH Keys & GitHub | "I have an identity online and a key that proves it's me." | 45 min | 02 |
| [05](modules/05-developer-folder/README.md) | The Developer Folder | "Code lives in a place. My place has a structure." | 20 min | 02 |
| [06](modules/06-tooling-installs/README.md) | Tooling: Python, Node, Git | "I have the languages and tools real projects need." | 45 min | 00 |
| [07](modules/07-terminal-config/README.md) | Terminal & Editor Config | "My terminal works the way my brain works." | 30 min | 01 |
| [08](modules/08-ide-and-git/README.md) | IDE & Git Workflow | "I can clone a repo, edit it, commit, and push." | 60 min | 04, 05, 06 |
| [09](modules/09-api-project/README.md) | Hitting an API | "I can talk to a service on the internet from code I wrote." | 60 min | 06, 08 |
| [10](modules/10-database-project/README.md) | A Tiny Database | "I can persist data and read it back later." | 60 min | 08 |
| [11](modules/11-pi-ssh/README.md) | SSH Into a Pi *(optional)* | "I can run a program on a computer that's not in front of me." | 45 min | 04 |

---

## How to Use This

Each module is standalone. Work through them in order or jump to a specific topic. The **Prereqs** column tells you what to do first.

Every module ends with a `verify.sh` script:

```bash
bash modules/00-start-here/verify.sh
```

Run it to confirm you completed the module correctly. Green checkmarks mean you're ready to move on.

To check your whole environment at once:

```bash
bash scripts/verify-env.sh
```

---

## What's in This Repo

```
modules/         ← the curriculum, one folder per module
scripts/         ← shared helper scripts (install-mac.sh, install-wsl.sh, verify-env.sh)
templates/       ← project starters (.gitignore, .env.example, poker-ledger-starter)
reference/       ← cheat sheets (shell-quick-ref.md, git-quick-ref.md, shortcuts.md)
archive/         ← old content kept for reference
```

---

## Quick Reference

- [Shell commands](reference/shell-quick-ref.md)
- [Git workflow](reference/git-quick-ref.md)
- [Keyboard shortcuts](reference/shortcuts.md)

---

## The Thesis

The command line is not a relic. It's the substrate of everything — every cloud provider, every CI/CD pipeline, every server in production runs on text commands. Finder and GUI tools are skins. Once you can work without the skin, you can work anywhere.

This curriculum teaches the substrate.
