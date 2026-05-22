# Git and GitHub

Git is not a backup system. It's a record of intent — every commit is a named snapshot that says "at this point, the code did this." GitHub is just a place to store that record online and share it.

The difference matters because it changes how you use it. You don't commit to save. You commit to mark a meaningful state.

---

## The Three States

Every file in a git repo is in one of these states:

```
Working directory   →   Staging area   →   Committed
  (changed)              (git add)          (git commit)
```

- **Working directory:** files you've edited but not staged
- **Staging area:** changes you've selected for the next commit
- **Committed:** permanent snapshot, part of the history

You choose what goes into each commit by staging specific files. You can commit part of your changes and leave the rest for later.

---

## Basic Workflow

```bash
git init                          # turn a folder into a git repo
git status                        # see what's changed and what's staged

git add app.py                    # stage a specific file
git add .                         # stage everything (be careful — see below)
git commit -m "add message board route"

git log --oneline                 # see history
git diff                          # see unstaged changes
git diff --staged                 # see staged changes
```

`git status` is free. Run it constantly. It tells you exactly where you are.

---

## .gitignore

Some files should never be committed: secrets, build artifacts, dependencies.

```bash
cat .gitignore
```

```
.venv/
node_modules/
__pycache__/
*.pyc
.env
```

If a file is in `.gitignore`, `git add .` will not touch it. But if you committed it before adding it to `.gitignore`, git is already tracking it — `.gitignore` only prevents new additions.

**Never commit `.env` files.** That's where API keys and passwords live.

---

## What `git add .` Actually Does

`git add .` stages everything in the current directory that isn't ignored. This is convenient but requires you to trust your `.gitignore`. Check `git status` after adding to see exactly what you're about to commit.

If you accidentally staged something:

```bash
git restore --staged filename.py   # unstage a file
```

---

## Commits as a Timeline

```bash
git log --oneline
```

```
a3f21c9 add websocket support for live updates
8b4de12 initial commit: flask server with weather route
```

Each line is a commit. The hash is its permanent ID. The message is what you decided was worth naming.

Make a change, check `git diff`, then:

```bash
git add app.py
git commit -m "fix: return 404 when message id not found"
```

Good commit messages say what changed and why it mattered. "fix stuff" is useless in six months.

---

## Pushing to GitHub

```bash
# After creating a repo on github.com:
git remote add origin git@github.com:username/repo-name.git
git push -u origin main
```

`git remote add origin` connects your local repo to the GitHub URL. `git push` sends your commits. `-u origin main` sets the default so future pushes are just `git push`.

---

## Why This Matters for the Pi

In Part 5, the Pi deploys by pulling from GitHub:

```bash
git clone git@github.com:username/repo.git
```

This is the same mechanism behind every CI/CD system. You push code to GitHub. Something (a server, a Pi, GitHub Actions) pulls it and runs it. The git history is the deployment mechanism.

---

## The Visual

```
Your laptop                    GitHub                    Raspberry Pi
     │                             │                           │
     │  git commit (local)         │                           │
     │──────────────────────────►  │                           │
     │  git push                   │                           │
     │                             │  git clone / git pull     │
     │                             │ ◄─────────────────────────│
```

---

## Hands-On

1. Run `git init` in your project directory. Run `git status`.
2. Check `.gitignore` — confirm `.venv/` and `__pycache__/` are listed.
3. Stage and commit all files: `git add . && git commit -m "initial commit"`
4. Make a visible change to `app.py`. Run `git diff`. Stage it. Run `git diff --staged`. Commit it.
5. Run `git log --oneline`. You should see two commits.
6. Push to a new GitHub repo. Verify the history appears on github.com.

---

## The Three Rules

1. **`git status` before every `add` and every `commit`.** Know what you're about to do.
2. **`.gitignore` before the first commit.** Much harder to clean up after.
3. **Commit messages in the imperative.** "add route" not "added route" or "adding route." Future you reads these like a changelog.
