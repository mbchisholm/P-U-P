# Module 08 — IDE & Git Workflow

> **You'll be able to:** Clone a repo, make changes in VS Code, commit them, and push to GitHub.
> **Time:** ~60 min
> **Prereqs:** Modules 04, 05, 06

## Why this matters

Git is not a backup system. It's a record of intent — every commit is a named snapshot that says "at this point, the code did this." GitHub is where you share that record. VS Code is the editor you'll write code in. This module wires all three together into the workflow you'll use for every project.

## Setup

```bash
cd ~/Developer/power-user-principles
```

---

## Install VS Code

Go to [code.visualstudio.com](https://code.visualstudio.com) and download for your OS.

### macOS
1. Download the `.zip`, open it — it extracts to `Visual Studio Code.app`
2. Drag to `/Applications`
3. Open from Applications

### Windows (WSL)
1. Download and install the Windows version of VS Code (not the Linux version)
2. Install the **WSL** extension inside VS Code
3. From your WSL terminal: `code .` — VS Code will open connected to WSL automatically

### Install the shell command (macOS)

So you can open VS Code from Terminal:
1. Open VS Code
2. Press `cmd+shift+p` to open the Command Palette
3. Type `shell command`
4. Click **Install 'code' command in PATH**

**Check:**
```bash
code --version
```

---

## Essential Extensions

Open the Extensions panel (`cmd+shift+x` / `ctrl+shift+x`) and install:

- **Python** (by Microsoft) — language support, linting, debugging
- **Prettier** — auto-formats code on save
- **GitLens** — shows git blame inline, rich git history

---

## The Three States of Git

Every file in a git repo is in one of three states:

```
Working directory   →   Staging area   →   Committed
  (you edited it)        (git add)          (git commit)
```

- **Working directory:** files you've changed but haven't told git about
- **Staging area:** changes you've selected for the next commit
- **Committed:** permanent snapshot in the history

You choose what goes into each commit by staging specific files. This lets you commit a bug fix separately from an unrelated cleanup, even if you edited both in the same session.

---

## Basic Git Workflow

```bash
git status                          # see what's changed and what's staged
git diff                            # see unstaged changes
git diff --staged                   # see staged changes

git add README.md                   # stage a specific file
git add .                           # stage everything not in .gitignore
git commit -m "add verify script for module 04"

git log --oneline                   # see history
```

`git status` is free. Run it constantly. It tells you exactly where you are.

**Try it:** Navigate to this repo and run `git status`. Then run `git log --oneline`. You should see the commit history.

---

## .gitignore

Some files should never be committed: secrets, compiled artifacts, virtual environments.

Check this repo's `.gitignore`:
```bash
cat .gitignore
```

If a file is in `.gitignore`, `git add .` will skip it. If you committed a file before adding it to `.gitignore`, git is already tracking it — `.gitignore` only prevents new additions.

**Never commit `.env` files.** That's where API keys live.

```bash
echo ".env" >> .gitignore    # add .env to gitignore
```

---

## Commit Messages

Good commit messages are imperative: "add route", "fix null pointer", "remove unused dependency". Not "added" or "adding".

The message is what future-you reads in `git log`. "fix stuff" is useless in six months. "fix: return 404 when session ID not found" is searchable and informative.

```bash
git commit -m "add verify.sh for module 04"
git commit -m "fix: handle missing .env file gracefully"
git commit -m "refactor: extract API key validation into helper"
```

---

## Pushing to GitHub

After creating a repo on github.com:

```bash
git remote add origin git@github.com:yourusername/repo-name.git
git push -u origin main
```

`git remote add origin` connects your local repo to GitHub. `git push` sends your commits. `-u origin main` sets the default — future pushes are just `git push`.

**Try it:** Create a new repo on GitHub called `pup-practice`. Initialize it locally, make a commit, push it, and verify the commit appears on GitHub.

---

## VS Code Git Integration

VS Code has a built-in Source Control panel (the branching icon in the left sidebar, or `ctrl+shift+g`). You can:

- See changes without running `git diff`
- Stage files by clicking the `+` next to them
- Commit from the text input at the top
- Push via the `...` menu

The Source Control panel is a GUI for the same operations you run in the terminal. Both do the same thing. Use whichever is faster for the task at hand.

---

## Branches

Branches let you work on something without touching the main line of code.

```bash
git checkout -b feature/my-change    # create and switch to a new branch
git checkout main                    # switch back to main
git merge feature/my-change          # merge your branch into main
git branch -d feature/my-change      # delete the branch after merging
```

Commit a lot. Commits are free. A branch with 20 small commits is easier to understand and debug than one with 1 giant commit.

---

## Verify

```bash
bash modules/08-ide-and-git/verify.sh
```

---

## What you can do now

You can clone a repo, open it in VS Code, edit files, commit your changes with meaningful messages, and push to GitHub. This is the core loop of software development.

## Stretch

- Run `git log --oneline --graph --decorate` — the graph shows branch history visually.
- Try `git diff HEAD~1` — see what changed in the last commit.
- Use `git stash` to temporarily save uncommitted changes: make a change, run `git stash`, see it disappear, then `git stash pop` to bring it back.
