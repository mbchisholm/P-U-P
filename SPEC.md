# Power User Principles — Workshop Redesign Spec

> Status: **Draft for review.** Recommendations are marked with **→**. Decisions still open are marked **❓**.

---

## 1. Premise

This is a ground-up redesign of the workshop from a single 45-minute live lesson into a **self-paced, modular curriculum** that takes a complete beginner from "I've never opened a terminal" to "I can SSH into my Raspberry Pi, hit an API, and ship code from VS Code."

The core shift: the **lesson is the setup**. Students start on a fresh OS profile and the workshop walks them through building their actual dev environment as the curriculum unfolds. No "do these installs beforehand" preamble. Cloning the scaffold repo is the first real act, and from there every install, config, and command is a teachable moment.

What changes from the original:

- **No live instructor narration.** Each module stands alone and carries its own pedagogy.
- **Mac + Windows.** Same curriculum, divergent setup paths early, convergent after.
- **Modular, not sequential.** Modules have prerequisites but no fixed schedule.
- **Step-by-step scaffold, not one-command bootstrap.** Every script the student runs is a moment of understanding, not a black box.

---

## 2. Audience

Unchanged from the original lesson:

- Uses computers every day, has never intentionally opened a terminal.
- Knows Finder/Explorer. Has *heard of* the command line.
- Slightly nervous, slightly curious, capable.
- Reads English fluently and can follow technical writing with patience.

**The voice stays the same:** direct, demystifying, no fluff. "This is simpler than you think, and more powerful than you realize." Strong conceptual claims, then the mechanics, then a payoff that proves it.

---

## 3. Platform strategy

**→ Recommendation: WSL-first for Windows.**

In Module 0, Windows students install WSL2 + Ubuntu and do the rest of the workshop inside the WSL shell. After Module 0, ~95% of the content is identical to Mac: same bash, same `ls`, same `~/Developer`, same SSH keys, same git, same VS Code (with the WSL extension).

Tradeoffs:

- ✅ Vastly less content branching downstream. Every lesson doesn't need a "but on Windows…" sidebar.
- ✅ Matches industry standard — most Windows devs work in WSL.
- ✅ The "shell is universal" thesis lands because it literally is, once you're in a Linux subsystem.
- ⚠️ Module 0 is heavier for Windows students (one extra install, one reboot, one concept: "what is WSL").
- ⚠️ A small number of native-Windows things (PowerShell, Windows Terminal config) don't get touched. That's a feature for this audience.

**Alternative considered:** native PowerShell path for Windows. Rejected — it doubles the maintenance surface of every lesson and forces a parallel pedagogy for `ls -la` vs `Get-ChildItem -Force`, `~` vs `$HOME`, etc.

**❓ Open:** does WSL-first conflict with any planned hardware/peripheral lesson? (USB passthrough in WSL is fiddly. Module 11's Pi SSH should be fine because it's over network, not USB.)

---

## 4. Format: self-paced modular

Each module is a standalone unit with:

- **Premise** — one paragraph: what this module proves, why it matters.
- **Prereqs** — explicit list of earlier modules required.
- **Estimated time** — "30 min if you read fast, 60 min if you try every example."
- **Setup** — what scaffold commands or scripts to run first.
- **Walkthrough** — the lesson body. Concept → command → check-yourself.
- **Verify** — concrete check the student runs to know they got it (`./scripts/verify-module-N.sh` or a manual command + expected output).
- **Stretch** — optional going-deeper exercises.
- **What you can do now** — explicit payoff statement. "You can now SSH into any server you have a key for."

**Implications:**

- No instructor crutch — every "aha moment" must be engineered into the writing.
- Lessons need verifiable end-states so students know they're done.
- Pacing is reader-controlled, so length isn't fixed — modules can be 20 min or 90 min.
- Slides become **optional reference cards**, not lecture aids. → likely cut from the initial scope; revisit later.

---

## 5. The scaffold repo

**❓ Decision: one repo or two?**

- **→ Recommendation: one repo.** The workshop content (lessons) and the scaffold (scripts, templates, starter projects) live together. Student does one `git clone`, everything is in one place, lessons can reference scaffold paths with stable relative links.
- **Alternative:** two repos. Cleaner separation but doubles the friction (two clones, two READMEs, cross-repo links). For an absolute beginner this is the wrong tradeoff.

**❓ Repo name.** Candidates: `power-user-principles` (current), `pup-workshop`, `power-user-starter`, `firstrun`. Pick one and rename. → Lean `power-user-principles` for continuity unless the brand needs to change.

**Scaffold structure (proposed):**

```
power-user-principles/
├── README.md                    ← landing page, module index, start-here
├── SPEC.md                      ← this file
├── modules/
│   ├── 00-start-here/
│   │   ├── README.md            ← module lesson
│   │   ├── mac.md               ← Mac-specific setup
│   │   ├── windows.md           ← Windows + WSL setup
│   │   └── verify.sh
│   ├── 01-terminal-and-shell/
│   │   ├── README.md
│   │   ├── examples/
│   │   └── verify.sh
│   ├── 02-filesystem/
│   ├── 03-processes-permissions/
│   ├── 04-ssh-and-github/
│   ├── 05-developer-folder/
│   ├── 06-tooling-installs/
│   ├── 07-terminal-config/
│   ├── 08-ide-and-git/
│   ├── 09-api-project/
│   ├── 10-database-project/
│   └── 11-pi-ssh/
├── scripts/                     ← shared helpers used across modules
│   ├── install-mac.sh
│   ├── install-wsl.sh
│   ├── new-project.sh
│   └── verify-env.sh
├── templates/                   ← project templates students copy from
│   ├── env-example/
│   ├── gitignore-starter/
│   └── poker-ledger-starter/
├── reference/                   ← cheat sheets, quick lookups
│   ├── shortcuts.md
│   ├── git-quick-ref.md
│   └── shell-quick-ref.md
└── archive/                     ← old content kept for reference, not active
```

**Each module's `verify.sh` is the gate.** Run it, it tells you green or what's missing. This replaces the instructor walking around the room checking that everyone got it.

---

## 6. Module sequence

Twelve modules. Each module's "what it proves" is the single sentence the student should be able to say at the end.

| #  | Title                            | What it proves                                                   | Est. time | Prereqs  |
|----|----------------------------------|------------------------------------------------------------------|-----------|----------|
| 00 | Start Here                       | "My machine is ready. I have a terminal and I cloned this repo." | 30–60 min | none     |
| 01 | The Terminal & The Shell         | "A shell is a program that takes text and runs it. That's it."   | 30 min    | 00       |
| 02 | The File System Is a Tree        | "Finder is a skin. I can navigate, create, and destroy from text."| 45 min   | 01       |
| 03 | Processes, Permissions, Networks | "Programs are processes. Files have owners. My machine has an IP."| 45 min   | 02       |
| 04 | SSH Keys & GitHub                | "I have an identity online and a key that proves it's me."       | 45 min    | 02       |
| 05 | The Developer Folder             | "Code lives in a place. My place has a structure."               | 20 min    | 02       |
| 06 | Tooling: Python, Node, Git       | "I have the languages and tools real projects need."             | 45 min    | 00       |
| 07 | Terminal & Editor Config         | "My terminal works the way my brain works."                      | 30 min    | 01       |
| 08 | IDE & Git Workflow               | "I can clone a repo, edit it, commit, and push."                 | 60 min    | 04, 05, 06|
| 09 | Hitting an API                   | "I can talk to a service on the internet from code I wrote."     | 60 min    | 06, 08   |
| 10 | A Tiny Database                  | "I can persist data and read it back later."                     | 60 min    | 08       |
| 11 | SSH Into a Pi                    | "I can run a program on a computer that's not in front of me."   | 45 min    | 04       |

**Notes on individual modules:**

- **00 Start Here** — diverges Mac/Windows; ends with student in a working bash shell having cloned this repo. The single most important module — if this lands, everything else does.
- **01 Terminal & Shell** — what a shell is, why it's text, the loop of input→program→output. Mostly conceptual, ~5 commands.
- **02 File System** — current `lessons/part1-shell.md` content lives here. `pwd`, `ls`, `cd`, `mkdir`, `touch`, `cat`, `rm`, pipes, `find`/`grep`.
- **03 Processes/Permissions/Networks** — `ps`, `top`/`htop`, `kill`, `chmod`/`chown`, `ifconfig`/`ip`, `ping`. Quick tour, not exhaustive. Just enough to demystify.
- **04 SSH & GitHub** — `ssh-keygen`, copy public key, paste into GitHub. Then `ssh -T git@github.com` to verify. Real account creation happens here.
- **05 Developer Folder** — `~/Developer/<org>/<repo>` convention. "Folders all the way down." Maybe 1 page.
- **06 Tooling** — `brew` (Mac) or `apt` (WSL), then `pyenv`/`python`, `nvm`/`node`, `git config`. Lots of pacing — "while this installs, here's *why* we use a version manager."
- **07 Terminal & Editor Config** — select-to-copy, paste, terminal tabs/panes (cmd+t, cmd+opt+arrows), `glow` for markdown, `bat` for syntax-highlighted `cat`. Short module, big quality-of-life win.
- **08 IDE & Git Workflow** — install VS Code, key extensions, open the cloned repo, make a change, use the source control panel, then the CLI equivalent. "Commit a lot. Commits are free." Stress structurally sound commits.
- **09 API Project** — OpenWeather API. Build a 30-line Python script. Introduces `.env`, `.gitignore`, `python-dotenv`, and **Claude Code** as a working tool, not a magic trick.
- **10 Database Project** — SQLite poker ledger. CLI script that logs sessions, queries totals. Reinforces files-on-disk = real state.
- **11 Pi SSH** — `pi/setup.sh` + `pi/scan.sh` content lives here. Find Pi on network, SSH in with the key from Module 04, run a thing.

---

## 7. Lesson format conventions

Every module README.md follows this template:

```markdown
# Module N — Title

> **You'll be able to:** <one-sentence payoff>
> **Time:** ~X min
> **Prereqs:** Module N-1, Module N-2

## Why this matters

<2-4 sentences. Sell the concept before the mechanics.>

## Setup

<Commands to run before starting. Usually `cd modules/NN-name/`>

## <Concept 1>

<Explain. Show. Try-it block. Verify-yourself block.>

## <Concept 2>

...

## Verify

Run:
\`\`\`bash
./verify.sh
\`\`\`

Expected output: <one line or screenshot>.

## What you can do now

<Restated payoff, more concrete than the header. "You can now ___, ___, and ___.">

## Stretch

- <Optional deeper exercise 1>
- <Optional deeper exercise 2>
```

**Code block conventions:**

- All shell commands in ` ```bash ` blocks.
- When OS-specific divergence is needed, use this two-block pattern:

  ```markdown
  ### macOS
  \`\`\`bash
  brew install glow
  \`\`\`

  ### Windows (WSL)
  \`\`\`bash
  sudo apt install glow
  \`\`\`
  ```

- Inline placeholders use `<angle-brackets>`. Example: `git clone git@github.com:<your-username>/<repo>.git`.
- Try-it blocks are signaled with **`Try it:`** in bold at the start of a line.
- Verify blocks are signaled with **`Check:`**.

**Visual treatments:**

- Warnings (irreversible commands, `rm -rf`, etc.) use blockquote `>` with explicit "this is permanent" framing.
- "Aha moments" — when a concept clicks — get a callout like `> 💡 ...` (kept rare; loses force if overused).
- Screenshots OK, but only when they show something the terminal can't (e.g., the GitHub UI flow in Module 04, VS Code extensions panel in Module 08).

---

## 8. Salvage from current content

| Current file                  | Fate                                                              |
|-------------------------------|-------------------------------------------------------------------|
| `INSTRUCTOR.md`               | Archive. Self-paced doesn't need instructor notes.                |
| `SETUP.md`                    | Cannibalize into Module 00 (Mac path).                            |
| `README.md`                   | Full rewrite — becomes the module index + start-here.             |
| `NOTES.md`                    | Keep at root as author's running notebook.                        |
| `lessons/part1-shell.md`      | Cannibalize into Modules 01, 02. Strong source material.          |
| `lessons/part1-slides.md`     | Archive. Slides not part of self-paced v1.                        |
| `lessons/part4-git.md`        | Cannibalize into Module 08.                                       |
| `lessons/part5-networking.md` | Cannibalize into Modules 03 and 11.                               |
| `pi/scan.sh`                  | Move to `modules/11-pi-ssh/`.                                     |
| `pi/setup.sh`                 | Move to `modules/11-pi-ssh/`.                                     |
| `project/starter/`            | Re-evaluate. May become Module 08's starting point, or archived.  |
| `project/complete/`           | Re-evaluate. Probably archived — Modules 09/10 build new projects.|
| `demos/1-bash-pipeline/`      | Cannibalize into Module 02 (pipes section).                       |
| `demos/2-static-web/`         | Archive. Doesn't fit the new arc.                                 |
| `demos/3-python/`             | Cannibalize into Module 06 (Python install verification).         |
| `demos/4-node/`               | Cannibalize into Module 06 (Node install verification).           |
| `demos/5-landing-page/`       | Archive.                                                          |
| `demos/6-generative-art/`     | Archive. Beautiful but off-arc.                                   |
| `demos/7-ssh-keys/`           | Cannibalize into Module 04. Strong source.                        |
| `setup.sh` (root)             | Reuse as base for `scripts/install-mac.sh`.                       |
| `.claude/`                    | Keep — useful for the eventual Claude Code module.                |

Archived content moves to `archive/` and stays git-tracked for reference.

---

## 9. Out of scope (explicit removals)

- **Live workshop format.** No instructor-led version in v1.
- **Slides.** Defer indefinitely. Reference cards in `reference/` cover the cheat-sheet need.
- **Native PowerShell path.** WSL only on Windows.
- **Mobile/iPad pathway.** Desktop OS only.
- **Cloud IDE alternatives** (Codespaces, etc.). Local-first.
- **The SHOP/homelab toolchain.** Separate project, already factored out.

---

## 10. Open decisions to resolve before implementation

These are calls only you can make:

1. **Repo name & brand.** Keep `power-user-principles`? Rename? Affects URLs, README, marketing.
2. **GitHub org / hosting.** Is this an Anthropic-adjacent project, a personal repo, or a TrellisLabs project?
3. **Code of conduct / contributor guide.** Are you accepting PRs from people who go through the workshop?
4. **OpenWeather API key strategy.** Free tier requires signup. Do students get their own key (real-world, with friction) or a shared workshop key (smooth, but security-weird)?
5. **Pi as a hard requirement.** Module 11 needs a Pi. Is it a stretch module, or part of the core sequence? If core, students need to acquire hardware.
6. **Claude Code as a tool taught in the workshop.** Module 09 introduces it. Confirm this is intended — it's a significant editorial choice and shapes the audience.
7. **Verify scripts: bash vs. cross-platform.** Bash-only is simplest under WSL-first. Confirm.
8. **License.** Currently unspecified. MIT? CC-BY?

---

## 11. Suggested implementation order

Don't try to build all 12 modules at once. Build the spine first, validate it works end-to-end with a real test student, then deepen.

1. **Restructure repo to match Section 5.** Move existing files, create `modules/`, `archive/`, etc. One PR.
2. **Module 00 (Start Here) — both platforms.** This is the hardest one and it gates everything. Get it bulletproof before anything else.
3. **Module 02 (File System).** Use existing `part1-shell.md` content. Validates the lesson format works.
4. **Verify scripts pattern.** Build the `verify.sh` for Modules 00 and 02. Establishes the convention.
5. **README rewrite.** Once 00 and 02 exist, the front-door README can sell the curriculum honestly.
6. **Find a test student.** Someone who's never opened a terminal. Watch them go through 00 → 02 cold. Note every place they stall.
7. **Iterate, then build out Modules 01, 03–11.** In rough sequence; some can be parallelized.
8. **Reference cards in `reference/`.** After core modules stabilize.

---

## 12. What this spec doesn't do

- Doesn't write the lesson text. Module READMEs are TBD.
- Doesn't write the scaffold scripts. Bash for `verify.sh`, `install-*.sh`, etc. are TBD.
- Doesn't commit to a launch date or audience size.
- Doesn't address translation, accessibility, or accommodations — worth a follow-up doc once the core is built.
