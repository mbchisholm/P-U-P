# Git Quick Reference

The day-to-day commands you'll run constantly. Bookmark this. See [shell-quick-ref.md](shell-quick-ref.md) for non-git shell commands and [shortcuts.md](shortcuts.md) for keyboard shortcuts.

## Core workflow

| Command | What it does |
|---|---|
| `git status` | What's changed and what's staged — run constantly |
| `git diff` | Unstaged changes |
| `git diff --staged` | Staged changes (what the next commit will include) |
| `git add <file>` | Stage a specific file |
| `git add .` | Stage everything not in `.gitignore` (check `git status` first) |
| `git commit -m "<msg>"` | Commit staged changes with a message |
| `git push` | Push commits to the remote |
| `git pull` | Pull commits from the remote |

## Setup (one-time)

| Command | What it does |
|---|---|
| `git config --global user.name "<Your Name>"` | Set the name attached to your commits |
| `git config --global user.email "<you@email.com>"` | Set the email attached to your commits |
| `git config --global init.defaultBranch main` | Use `main` instead of `master` for new repos |
| `git config --global core.editor "code --wait"` | Use VS Code for commit messages and merges |

## Starting a repo

| Command | What it does |
|---|---|
| `git init` | New git repo in the current directory |
| `git clone <url>` | Clone an existing repo |
| `git clone <url> <dir>` | Clone into a specific folder name |

## History

| Command | What it does |
|---|---|
| `git log --oneline` | Compact history (one commit per line) |
| `git log --oneline --graph --decorate` | History with branch graph |
| `git show <hash>` | Show a specific commit (the diff and message) |
| `git diff HEAD~1` | What changed in the most recent commit |
| `git blame <file>` | Show who last changed each line |

## Branches

| Command | What it does |
|---|---|
| `git branch` | List local branches (current one starred) |
| `git checkout -b <name>` | Create a new branch and switch to it |
| `git checkout <name>` | Switch to an existing branch |
| `git merge <name>` | Merge `<name>` into the current branch |
| `git branch -d <name>` | Delete a merged branch |

## Undoing

| Command | What it does |
|---|---|
| `git restore <file>` | Discard unstaged changes (**destructive**) |
| `git restore --staged <file>` | Unstage a file (keeps the changes) |
| `git stash` | Temporarily save uncommitted changes |
| `git stash pop` | Restore the most recently stashed changes |

## Remotes

| Command | What it does |
|---|---|
| `git remote -v` | List configured remotes |
| `git remote add origin <url>` | Add a remote called `origin` |
| `git push -u origin main` | Push and set `origin/main` as upstream (first time) |

## Commit message convention

Write in the **imperative mood**: `add`, `fix`, `remove`, `update` — not `added` or `adding`.

```
add verify script for module 04
fix: return 404 when session not found
refactor: extract API key validation
docs: update module 02 README
```

The message is what future-you reads in `git log`. "fix stuff" is useless in six months. "fix: handle missing .env gracefully" is searchable and informative.
