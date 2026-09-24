# Module 12 — Git in Practice

> **You'll be able to:** Decide — without asking anyone — whether a change needs a commit, a branch, a pull request, or an issue.
> **Time:** ~45 min
> **Prereqs:** Module 08

## Why this matters

Module 08 taught you the buttons. This module teaches you *when to press them*.

Most people learn git backwards. They memorize `checkout -b` and `merge` on day one, start opening pull requests on repos where they're the only human, and end up doing paperwork for an audience of zero. They never develop judgment, because they were handed the ceremony before they ever felt the problem the ceremony solves.

So we're doing it in the order the problems actually arrive.

---

## The one rule

Everything in this module comes from a single idea:

> **Match the ceremony to the cost of being wrong.**

A typo fix in your own project costs nothing to get wrong — so it costs nothing to fix. Commit it to `main` and move on. A change to a repo your brother is also working in can ruin his afternoon — so it gets a branch, a pull request, and a second pair of eyes.

That's the whole decision. Everything below is just that rule applied.

| Cost of being wrong | What you use |
|---|---|
| Nothing — it's my repo and it's small | Commit straight to `main`, push |
| I might want to throw this away | Branch, merge it yourself |
| Someone else depends on this repo | Branch + pull request |

---

## Stage 1 — The daily loop

**Use this for: your own projects, working alone. Which is most of what you'll do for a while.**

This is the loop. Not a simplified version of the loop — the actual loop, the one that professionals run dozens of times a day.

```bash
git status                       # where am I? what's changed?
#   ...edit your files...
git diff                         # what did I actually change?
git add <the files you meant>
git commit -m "fix: handle empty input"
git push
```

That's it. No branches. No pull requests. You are the only person here.

### When do I commit?

**When you finish a thought.**

Here's the test, and it's a good one: *can you describe what you did in one line, without using the word "and"?*

- "add the weather API key loader" → one thought. Commit it.
- "add the API key loader **and** fix the date formatting" → two thoughts. Two commits.

Commits are free. A day with twelve small commits is easier to read, easier to debug, and easier to undo than a day with one enormous one. You are writing a record of intent, not saving a file.

### When do I push?

**When you stand up.** Coffee, lunch, end of the day. Pushing puts your work on a computer that isn't your laptop. That's the only backup property git gives you, and it only kicks in after `push`.

### Don't do this yet

- **Don't create branches.** You have nothing to protect yourself from.
- **Don't open pull requests.** Nobody will review it. You'll click merge on your own work and learn nothing.
- **Don't `git add .` without running `git status` first.** Look before you stage.

**Try it:** In your practice repo, make three unrelated small changes to three files. Now commit them as *three separate commits*, staging one file at a time. Run `git log --oneline` and read the story you just wrote.

---

## Stage 2 — The branch

**Trigger: "I want to try something, and I might throw it away."**

You'll feel this one before you need it. You have working code. You want to try a rewrite, a new library, a different approach — and you don't want to lose the version that works.

That's a branch. It's a parallel save file.

```bash
git checkout -b try/new-parser    # a copy of main you can wreck
#   ...experiment, commit freely...

# It worked:
git checkout main
git merge try/new-parser
git branch -d try/new-parser

# It didn't:
git checkout main
git branch -D try/new-parser      # capital D — throw it away
```

The point of the branch is not organization. It's that **`main` stays working the entire time.** You can always `git checkout main` and be back on solid ground in one second.

### Naming

Four prefixes cover almost everything:

| Prefix | For |
|---|---|
| `fix/` | something is broken |
| `feat/` | something new |
| `docs/` | writing, not code |
| `try/` | an experiment you may delete |

`fix/empty-input-crash`. `feat/csv-export`. Short, lowercase, hyphens.

### Don't do this

- **Don't branch for a one-line fix.** The branch is more work than the change.
- **Don't let a branch live more than a few days.** Every day it exists, `main` drifts further away and the merge gets worse. If a branch is a week old, it should have been three branches.

**Try it:** On `main`, commit a file that prints something. Branch to `try/experiment`, change the message, commit. Run `git checkout main` and `cat` the file — your change is gone. `git checkout try/experiment`, `cat` again — it's back. Two versions, one folder, one second apart.

---

## Stage 3 — The pull request

**Trigger: someone else's eyes need to be on this before it lands.**

This is the stage that starts when you and I work in the same repo.

A pull request is not a git feature — git doesn't know what a PR is. It's a GitHub feature, and it's exactly one thing: **a conversation attached to a diff.** You are literally *requesting* that someone *pull* your branch into theirs. The name is honest.

### The collaboration loop

Once a repo has more than one person in it, this replaces the Stage 1 loop:

```bash
git checkout main
git pull                            # ALWAYS. get their changes first.
git checkout -b fix/login-timeout
#   ...work, commit, commit...
git push -u origin fix/login-timeout
#   → open the PR on github.com, describe what and why
#   → I review it, you address comments, you merge
git checkout main
git pull                            # now main has your work in it
git branch -d fix/login-timeout
```

**`git pull` before you start is the rule you cannot skip.** Nearly every miserable git story a beginner tells starts with branching off a stale `main`.

### What makes a PR good

- **Small.** If you can't explain it in three sentences, it's two PRs.
- **One topic.** A bug fix and a refactor in the same PR means the reviewer can't see either clearly.
- **The description says *why*.** The diff already shows *what*. What it can't show is what you were trying to do, and what you decided against.

### Don't do this

- **Don't open a PR on a repo where you're the only person** — with two exceptions, and they're real ones: you want the side-by-side diff view to review your own work before it lands, or the repo runs automated tests on PRs and you want them to run. Both are legitimate. "Because it's what real developers do" is not.
- **Don't push straight to `main` on a shared repo.** Ever. Even for a typo. The moment someone else's work depends on `main` being sane, `main` is not yours to edit directly.

---

## Stage 4 — Issues

**Trigger: "I just thought of something I'm not going to do right now."**

An issue is a thought you don't want to lose. That's all. It is not a project management system and you are not required to have one.

Open an issue when:

1. You found a bug but you're in the middle of something else.
2. You have an idea for later that you'll otherwise forget.
3. You want *someone else* to do something.

**Don't open an issue for something you're about to do in the next ten minutes.** Just do it. Two clicks of overhead to track a task that ends before you finish typing it is pure loss.

The useful habit: when you're working and notice something unrelated and broken — *don't fix it.* Open a one-line issue, stay on task, come back later. This is most of what issues are actually for.

---

## The decision card

Print this. It's the whole module.

| You're about to… | Do this |
|---|---|
| Change something small in your own repo | Commit to `main`, push |
| Try something risky in your own repo | `git checkout -b try/thing` |
| Change *anything* in a shared repo | Branch + PR |
| Start work on a shared repo | `git pull` **first** |
| Notice an unrelated bug mid-task | Open an issue, stay on task |
| Finish a thought | Commit |
| Stand up from your desk | Push |

It also lives at [reference/git-decisions.md](../../reference/git-decisions.md), alongside the panic table for when things go sideways.

---

## You are not stuck

Beginners quit git at the first state they don't recognize. So learn this now: **git almost never loses committed work.** If you committed it, it exists, even when you can't see it.

```bash
git reflog
```

That's every position `HEAD` has been in for the last 90 days — including the commits you "lost." `git checkout <hash>` from that list and your work is back.

The full panic table is in [reference/git-decisions.md](../../reference/git-decisions.md). Read it *before* you need it.

---

## Verify

```bash
bash modules/12-git-in-practice/verify.sh
```

---

## What you can do now

You can look at a change and know, without asking, whether it deserves a commit, a branch, a pull request, or an issue — and you know why each answer is the right one. You can work alone without ceremony and drop into a shared repo without breaking anyone's day.

## Stretch

- Run `git log --oneline --graph --decorate --all` on a repo with branches. Read the shape.
- Open a PR on your own practice repo just to see the interface — the Files Changed tab, line comments, the merge button. Then close it without merging.
- Find a real open-source repo you use and read its three most recent merged PRs. Notice how small they are.
- Make a commit, then run `git reset --hard HEAD~1` to "lose" it. Recover it with `git reflog`. Do this *once*, on a throwaway repo, so you know in your body that it's recoverable.
