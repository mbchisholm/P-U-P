# Module 12 — Frontend Design

> **You'll be able to:** Look at a UI and name exactly what's wrong with it — then fix it, by hand and with an AI assistant that knows the rules.
> **Time:** ~90 min
> **Prereqs:** Modules 06, 08 · Module 09's Claude Code section

## Why this matters

It has never been easier to ship a working frontend — and never easier to ship an ugly one. AI assistants and component libraries happily generate interfaces that *function* but read as generic slop: three competing accent colors, purple gradients, animations that stutter, buttons a keyboard can't reach.

Here's the secret this module is built on: for product interfaces, **good design is mostly the absence of known mistakes**. Not talent. Not inspiration. A finite list of mistakes, each one nameable and checkable. Designers aren't seeing something you can't see — they've just already named what you're only feeling.

So this module does two things, in order. First it trains your eye on a deliberately bad page, so "something feels off" becomes "*that* is off, and here's why." Then it hands you the checklist in executable form — **skills**, files that teach your AI assistant the same rules — and you use them to fix the page, and then your own projects, forever.

## Setup

You need this repo cloned (Module 00) and Node installed (Module 06).

```bash
cd ~/Developer/power-user-principles/modules/12-frontend-design
```

Open the demo page in your browser:

```bash
open demo/slop.html          # Mac
explorer.exe demo/slop.html  # WSL
```

Click around. Add a task. Try to delete one. Everything *works*.

---

## Part 1 — Learn to see

Before reading further: **write down three things you would change about that page.** Actually write them down — the point of this part is to compare what you *felt* with what you can *name* afterward.

Done? Here are six problems hiding in plain sight. For each one: the symptom you felt, the rule it breaks, and why the rule exists.

### 1. Nothing is loudest

The hero is a three-color gradient. The buttons are different gradients with glow. The headings are green, the delete icons pink, "Clear all" red. When everything shouts, nothing is important — the whole point of visual hierarchy is that **one thing per view is loudest**: one accent color, one primary action, everything else quiet. Gradients and glow aren't automatically wrong, but they're the single loudest marker of AI-generated UI, and restraint is what reads as confidence.

### 2. The keyboard can't use it

Press Tab a few times on the page. The **＋** button, the delete **✕**, "Clear all" — you can't reach any of them, because they're `<div onclick="...">`, not `<button>`. A `<div>` is invisible to keyboards and screen readers; a `<button>` gets focus, Enter, Space, and announcement for free. This is the highest-stakes rule in the module: **use the native element, and never rebuild keyboard behavior by hand.** Also: the ＋ has no text, so even as a button a screen reader would announce it as, literally, nothing — icon-only controls need an `aria-label`.

### 3. The error happens somewhere else

Click ＋ with the input empty. The error appears… at the top of the page, in a banner, nowhere near where you're looking, saying "Something went wrong" about nothing in particular. **Errors belong next to the action that caused them**, saying specifically what to fix. And the inputs have no labels at all — placeholder text vanishes the moment you type, which is exactly when you forget which field is which.

### 4. The motion is doing work it shouldn't

Hover the "GET STARTED" button. It takes nearly a second to swell — and it swells by animating its *padding*, which forces the browser to recalculate the layout of the page on every frame. That's what stuttering *is*. The rules: **animate only `transform` and `opacity`** (the browser can composite those on the GPU without touching layout), keep interaction feedback **under 200ms**, and use **`ease-out`** so motion decelerates like a physical thing. Slow + `ease-in` + layout animation is the trifecta of sluggish.

### 5. The typography is fighting you

Every line of text on the page is letter-spaced apart — a default-looking font stretched thin reads as cheap, not elegant (**never touch `letter-spacing` without a reason**). The hero paragraph is a 40-word run-on. And look at the stats table: the numbers are left-aligned in their column with digits of different widths, so nothing lines up — data wants **right-aligned, `tabular-nums`** so every digit occupies the same width.

### 6. The parts you can't see are missing

Look at the browser tab: no title. There's no meta description (what search results and link previews show), and no viewport tag — which means on a phone this page renders zoomed-out and tiny. And `height: 100vh` on the hero is why content hides behind the URL bar on mobile browsers; `100dvh` accounts for the browser chrome. The invisible parts of a page are part of its design.

**Check yourself:** how many of your three written-down complaints just got named? That gap — between felt and named — is the thing this module closes. There are more than six problems in that file, by the way. The rest are for the tools to catch.

---

## Part 2 — The checklist is a file

In Module 09 you met Claude Code as a collaborator. A **skill** is how you teach it standards: a folder holding a `SKILL.md` — plain markdown with a name, a description, and rules. When a skill is installed, you invoke it like a slash command and the assistant applies its constraints.

Everything in Part 1 came from a real, open-source ruleset: [UI Skills](https://www.ui-skills.com) by design engineer Julien Thibeaut, MIT-licensed, and pre-installed in this repo. Look — it's just a text file:

```bash
head -40 ../../.claude/skills/baseline-ui/SKILL.md
```

Notice the format: `MUST`, `SHOULD`, `NEVER`. No vibes. Rules — the same ones you just learned, plus dozens more, written so a machine can enforce them.

Six skills ship in this repo's `.claude/skills/`:

| Skill | What it's for |
|-------|---------------|
| `/baseline-ui` | The core checklist: hierarchy, spacing, typography, motion, layout |
| `/fixing-accessibility` | Names, keyboard access, focus, form errors, contrast |
| `/fixing-motion-performance` | Why animations stutter, and how to fix them |
| `/fixing-metadata` | Titles, descriptions, viewport, social share cards |
| `/improve-ui` | Read-only *audit* of a real project — proves findings, writes plans, touches nothing |
| `/ui-skills-root` | The router — give it any UI task, it picks the right skill |

To install them in **your own** projects later, run `npx ui-skills` from the project root and the CLI walks you through it.

---

## Part 3 — Fix the page

Now close the loop. You'll point the skills at `slop.html` and drive the fix yourself. Don't worry about breaking it — the file is committed, so `git checkout -- demo/slop.html` resets it any time (Module 08 paying rent).

**1. Start Claude Code in this module's directory:**

```bash
claude
```

**2. Run the baseline pass:**

```
/baseline-ui demo/slop.html
```

Read the output before you act on it. Every violation is quoted from *your* file with a reason and a fix — this is a design review, the same shape as the code review you'd get on a real team. Then ask Claude to apply the fixes, and **read the diff it makes** (`git diff demo/slop.html`). You just learned these rules; check they were applied the way you'd expect.

**3. Run the accessibility pass:**

```
/fixing-accessibility demo/slop.html
```

Then verify with your own hands: reload the page and use it **without the mouse**. Tab to the input, type a task, Tab to the add button, press Enter. If you can't complete the whole flow by keyboard, the pass isn't done.

**4. Run the metadata pass:**

```
/fixing-metadata demo/slop.html
```

Check the browser tab afterward — the page has a name now.

**5. Look at what changed.** Reload `slop.html` next to a fresh checkout, or diff against the reference answer in `demo/after.html` (no peeking before this point — it's one *possible* good version, not the only one). The page didn't gain features. It lost mistakes. That's the whole trick.

**6. Commit it:**

```bash
git add demo/slop.html
git commit -m "deslop the demo page"
```

---

## Part 4 — Start from clean, not from scratch

You just spent an hour removing mistakes from a page. The cheaper move, next time, is to never type them: **don't start UIs from a blank file.** A blank file invites improvisation, and improvisation is where slop comes from.

This repo ships six clean starting points in [`templates/ui-starters/`](../../templates/ui-starters/README.md) — a landing page, an app dashboard, a form, a long-form article page, and a light/dark-themed blog pair (front page + post page). Each is one dependency-free HTML file that opens with a double-click, and each already follows every rule from this module. Open a couple next to your fixed `slop.html`:

```bash
open ../../templates/ui-starters/dashboard.html   # Mac
explorer.exe ..\\..\\templates\\ui-starters\\dashboard.html  # WSL
```

Now look at the top of any starter's CSS. They all begin with the same block:

```css
:root {
  --accent: #4f46e5;   /* the ONE accent color */
  --ink: #1a1a1a;      /* text */
  --muted: #6b7280;    /* secondary text */
  --line: #e5e7eb;     /* borders */
  --surface: #f9fafb;  /* panels */
  ...
}
```

These are **design tokens** — the page's every color decision, named once, used everywhere. Change `--accent` to `#0d9488` and reload: the whole page re-themes and nothing breaks, because no color was ever hard-coded twice. This is the single most reusable idea in this module. It's the same mechanism behind Tailwind's theme and every design system you'll ever meet — the starters are just small enough that you can see all of it at once.

**Try it:** copy `form.html` into a scratch folder, change three tokens, and make it yours. The [starters README](../../templates/ui-starters/README.md) has the full reuse recipe — including how to keep all four pages reading as one product by sharing the token block.

---

## Part 5 — Now a real project

The demo page was the training ground and the starters are the head start. The skills earn their keep on projects that matter — one of yours.

One warning before you start: the instinct is to open your project and say "make it pretty." Resist it. You'll get a *different* generic UI, not a better version of yours. The professional loop is **audit → plan → apply → verify**, and there's a skill specifically for the first step:

1. **Install the skills there.** From your project's root: `npx ui-skills` (or copy the folders from this repo's `.claude/skills/`).
2. **Audit first.** Run `/improve-ui` in Claude Code. It's strict by design: read-only, only reports problems it can *prove* against your project's own evidence, and ends with a findings table asking which ones you want implementation plans for.
3. **Apply in passes.** Work through findings with `/baseline-ui <file>`, then the targeted skills, exactly like Part 3. **Commit before and after each pass** — the diff is your before/after screenshot in text form.
4. **Look at it.** Rules catch mistakes; only your eyes confirm the result.

One more thing you'll meet in real projects: the skills are opinionated about tools. If your project uses React, they'll reach for **Tailwind CSS** (its real product is the default spacing scale — consistent spacing becomes the path of least resistance), **`motion/react`** for JavaScript animation, and accessible primitives like **Base UI** or **Radix** — pre-built dialogs, menus, and tabs with the keyboard behavior already correct. You don't need to learn these now. Recognize the names, and remember why they exist: each one removes a category of mistake you now know by name.

---

## Verify

```bash
bash modules/12-frontend-design/verify.sh
```

This checks your *fixed* `slop.html` — it fails until the gradients, blocked paste, div-buttons, and missing labels are actually gone.

---

## What you can do now

You can look at an interface and name what's wrong with it: competing accents, layout-property animation, errors far from their cause, controls a keyboard can't reach, spacing off the scale. You can install a ruleset into any project and have your AI assistant enforce it — and review its work, because you know the rules yourself. You can start any new UI from a clean, token-themed page instead of a blank file. And you know the loop: audit before you edit, commit before and after. That's not a design trick; it's how careful engineers change anything.

All of it fits on one page: [reference/frontend-design-quick-ref.md](../../reference/frontend-design-quick-ref.md). Bookmark it next to the git and shell cards.

## Stretch

- Read the other five `SKILL.md` files end to end. They're short, and they're a masterclass in turning judgment into checkable rules.
- Re-theme all four starters to one brand of your invention — same token values in every file — and confirm they read as one product. Congratulations, you've built a design system.
- Build a real page for one of your projects by combining starters: `landing.html` structure with `article.html`'s prose column, say. The tokens make the seams invisible.
- Deploy something (GitHub Pages is free) and paste the link into a chat app. `/fixing-metadata` is the difference between a naked URL and a real preview card.
- Write a skill of your own: `.claude/skills/my-rules/SKILL.md` in one of your projects, encoding three rules you keep repeating. You know the format now.
- Browse the full registry at [ui-skills.com](https://www.ui-skills.com) — community skills for Next.js, Vue, React Native, 3D, and more.
