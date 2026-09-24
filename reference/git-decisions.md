# Git Decisions

`git-quick-ref.md` tells you **what the commands do**. This tells you **which one you want**.

See [git-quick-ref.md](git-quick-ref.md) for syntax, and [Module 12](../modules/12-git-in-practice/README.md) for the reasoning behind all of it.

---

## The one rule

> **Match the ceremony to the cost of being wrong.**

| Cost of being wrong | What you use |
|---|---|
| Nothing — my repo, small change | Commit to `main`, push |
| I might throw this away | Branch, merge it yourself |
| Someone else depends on this repo | Branch + pull request |

---

## The decision card

| You're about to… | Do this |
|---|---|
| Change something small in your own repo | Commit to `main`, push |
| Try something risky in your own repo | `git checkout -b try/thing` |
| Change *anything* in a shared repo | Branch + PR |
| Start work on a shared repo | `git pull` **first** |
| Notice an unrelated bug mid-task | Open an issue, stay on task |
| Finish a thought | Commit |
| Stand up from your desk | Push |

---

## When to commit

**When you finish a thought.**

The test: *can you describe it in one line without the word "and"?*
If you need "and," that's two commits.

Commits are free. Twelve small ones beat one big one, every time.

---

## When to branch

**When you might throw the work away.** The branch exists so `main` keeps working while you experiment.

| Prefix | For |
|---|---|
| `fix/` | something is broken |
| `feat/` | something new |
| `docs/` | writing, not code |
| `try/` | an experiment you may delete |

**Don't** branch for a one-line fix. **Don't** let a branch live more than a few days — old branches merge badly.

---

## When to open a PR

**When someone else's eyes need to be on this before it lands.**

A PR is a conversation attached to a diff. On a shared repo, every change gets one — even a typo.

Good PRs are **small** (three sentences or it's two PRs), **one topic**, and the description says **why**, because the diff already shows what.

**Don't** open a PR on a repo where you're the only person — unless you want the diff view to review your own work, or the repo runs tests on PRs. Those are the only two good reasons.

---

## When to open an issue

**When you thought of something you're not going to do right now.**

1. A bug you found mid-task
2. An idea for later
3. Something you want someone else to do

**Don't** open one for something you'll finish in ten minutes. Just do it.

---

## The loops

**Alone, your own repo:**

```bash
git status
#   ...edit...
git diff
git add <files>
git commit -m "fix: handle empty input"
git push
```

**Shared repo:**

```bash
git checkout main
git pull                          # never skip this
git checkout -b fix/login-timeout
#   ...work, commit...
git push -u origin fix/login-timeout
#   → open PR, get review, merge
git checkout main && git pull
git branch -d fix/login-timeout
```

---

## Panic table

Read this *before* you need it. Committed work is almost never lost.

| What happened | What's actually true | Do this |
|---|---|---|
| "I don't know what state I'm in" | Always recoverable | `git status`, then `git log --oneline --graph --all` |
| "I lost a commit" | You didn't | `git reflog` — every `HEAD` position for 90 days. `git checkout <hash>` |
| "I committed to `main`, meant to branch" (not pushed) | Easy fix | `git branch feat/thing` to bookmark it, then `git reset --hard origin/main` (**destructive** — only with nothing uncommitted), then `git checkout feat/thing` |
| "I have a merge conflict" | Not an error. Git is asking a question it can't answer | Open the file, find `<<<<<<<` / `=======` / `>>>>>>>`, delete the markers and keep the code you want, then `git add` and `git commit` |
| "I staged the wrong file" | Nothing is committed yet | `git restore --staged <file>` (keeps your edits) |
| "I want to undo my edits to a file" | Gone for good once you do this | `git restore <file>` (**destructive**) |
| "I need to switch tasks but I'm mid-change" | — | `git stash`, switch, then `git stash pop` |
| "My push was rejected" | Someone pushed before you | `git pull`, resolve anything conflicting, push again |
| "I committed a secret" | Serious — treat the key as burned | **Rotate the key first.** Then remove it from history. Assume anything pushed to GitHub is public forever |

---

## The three things that cause most beginner pain

1. **Not running `git pull` before starting work on a shared repo.** Nearly every bad git story starts here.
2. **Branches that live too long.** A week-old branch should have been three branches.
3. **`git add .` without looking.** Run `git status` first. Every time.
