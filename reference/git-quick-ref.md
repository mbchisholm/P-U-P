# Git Quick Reference

## Core Workflow
```bash
git status                        # see what's changed (run this constantly)
git diff                          # unstaged changes
git diff --staged                 # staged changes

git add <file>                    # stage a file
git add .                         # stage everything (check status first)
git commit -m "message"           # commit staged changes
git push                          # push to remote
git pull                          # pull from remote
```

## Setup
```bash
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
git config --global init.defaultBranch main
```

## Starting
```bash
git init                          # new repo in current directory
git clone git@github.com:org/repo.git    # clone existing repo
```

## History
```bash
git log --oneline                 # compact history
git log --oneline --graph         # with branch graph
git show <hash>                   # show a specific commit
git diff HEAD~1                   # what changed in the last commit
```

## Branches
```bash
git branch                        # list branches
git checkout -b feature/name      # create and switch to branch
git checkout main                 # switch to main
git merge feature/name            # merge branch into current
git branch -d feature/name        # delete branch
```

## Undoing
```bash
git restore <file>                # discard unstaged changes (destructive)
git restore --staged <file>       # unstage a file
git stash                         # temporarily save uncommitted changes
git stash pop                     # restore stashed changes
```

## Remote
```bash
git remote -v                     # show remotes
git remote add origin <url>       # add a remote
git push -u origin main           # push and set upstream
```

## Commit Message Convention
Write in the imperative mood: "add", "fix", "remove", "update" — not "added" or "adding".

```
add verify script for module 04
fix: return 404 when session not found
refactor: extract API key validation
docs: update module 02 README
```
