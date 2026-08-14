# Module 12 — Frontend Design

> **You'll be able to:** Take a working-but-ugly UI from one of your own projects and upgrade it into something that looks designed — using a repeatable checklist, not taste.
> **Time:** ~90 min (plus however deep you go on your own project)
> **Prereqs:** Modules 06, 08 · Module 09's Claude Code section

## Why this matters

It has never been easier to ship a working frontend, and it has never been easier to ship an ugly one. AI assistants and component libraries will happily generate interfaces that *function* but read as generic slop: inconsistent spacing, purple gradients, animations that stutter, buttons a keyboard can't reach. The difference between that and a professional interface is not artistic talent. It's a set of constraints — spacing scales, typography rules, motion budgets, accessibility contracts — that you can learn, check, and enforce. This module gives you those constraints as *skills*: files that teach your AI assistant the rules, so every UI you build or fix from now on starts from a professional baseline.

## Setup

You need this repo cloned (Module 00) and Node installed (Module 06). Check both:

```bash
cd ~/Developer/power-user-principles
node --version    # any recent version is fine
ls .claude/skills # you should see six skill folders
```

---

## What "good design" actually is

Forget inspiration. For product interfaces, good design is mostly the *absence of mistakes*:

- **Spacing** comes from a scale (4, 8, 12, 16, 24…), not from nudging pixels until it "looks right."
- **Hierarchy** means one thing per view is loudest. One accent color. One primary action.
- **Typography** does the heavy lifting: balanced headings, readable body text, numbers that line up in tables.
- **Motion** is feedback, not decoration. Fast (under 200ms), physical (ease-out), and only on properties the browser can animate cheaply.
- **Accessibility** is not a feature — it's whether your UI works at all for keyboard and screen-reader users.

Every one of those is checkable. Which means every one of them can be written down as a rule and handed to a machine.

---

## Skills: rules your AI assistant can follow

In Module 09 you met Claude Code as a collaborator. A **skill** is how you teach that collaborator your standards: a folder containing a `SKILL.md` file — plain markdown with a name, a description, and the rules. When a skill is available, you can invoke it like a slash command (`/baseline-ui`) and the assistant applies its constraints to whatever you're doing.

Look at one right now — it's just a text file:

```bash
head -40 .claude/skills/baseline-ui/SKILL.md
```

Notice the format: `MUST`, `SHOULD`, `NEVER`. No vibes. Rules.

This repo ships with six skills from [UI Skills](https://www.ui-skills.com) (an open-source, MIT-licensed collection by design engineer Julien Thibeaut) pre-installed in `.claude/skills/`. Because they're in the repo, any Claude Code session you start here already has them.

| Skill | What it's for |
|-------|---------------|
| `/ui-skills-root` | The router — give it a UI task, it picks the smallest useful skill |
| `/baseline-ui` | The core checklist: stack, spacing, typography, motion, layout |
| `/improve-ui` | A read-only *audit* — finds proven design problems, writes plans, touches nothing |
| `/fixing-accessibility` | Names, keyboard access, focus, form errors, contrast |
| `/fixing-motion-performance` | Why animations stutter, and how to fix them |
| `/fixing-metadata` | Titles, descriptions, social cards — how your page looks when shared |

**Install them in your own projects.** From any project root:

```bash
npx ui-skills
```

The CLI lets you browse and add skills; they land in that project's skill folder the same way. (`npx` runs a package without permanently installing it — you saw the pattern in Module 06.)

---

## The frameworks the skills assume

The skills aren't abstract advice — they're opinionated about tools. This stack is the current mainstream for React frontends, and each piece exists to *remove decisions*:

- **[Tailwind CSS](https://tailwindcss.com)** — utility classes (`p-4`, `text-sm`, `shadow-md`) whose real product is its **default scale**. When every padding value comes from the same scale, consistent spacing stops being discipline and becomes the path of least resistance. Rule one of `baseline-ui`: use Tailwind defaults unless you have a reason not to.
- **[motion](https://motion.dev)** (`motion/react`, formerly Framer Motion) — the standard library for JavaScript-driven animation in React, for when CSS transitions aren't enough.
- **[tw-animate-css](https://github.com/Wombosvideo/tw-animate-css)** — ready-made Tailwind classes for entrance and micro-animations, so you don't hand-roll keyframes.
- **`cn` utility** (`clsx` + `tailwind-merge`) — the small helper every Tailwind project ends up with for combining classes conditionally without conflicts.
- **Accessible primitives — [Base UI](https://base-ui.com), [Radix](https://www.radix-ui.com), [React Aria](https://react-spectrum.adobe.com/react-aria/)** — unstyled components (dialogs, menus, tabs) with keyboard and focus behavior already correct. The single highest-leverage rule in the whole system: **never rebuild keyboard or focus behavior by hand.** Decades of edge cases live in these libraries; use them and style on top.

You don't need to master these now. You need to recognize them, because the skills will reach for them — and because "which library does the community trust for X" is exactly the kind of thing a power user knows how to find out.

---

## The rules that do the most work

Read `baseline-ui` in full (it's 85 lines). These are the ones that kill the most slop, with the *why*:

**Typography**

- `text-balance` on headings, `text-pretty` on paragraphs — the browser rebalances line breaks so you never get a heading with one orphaned word.
- `tabular-nums` for data — every digit gets equal width, so numbers in tables and timers line up instead of jittering.

**Motion**

- Animate only `transform` and `opacity`. The browser can composite these on the GPU without recalculating layout; animating `width`, `height`, or `margin` forces layout work every frame — that's what stuttering *is*.
- Interaction feedback under 200ms, `ease-out` on entrances. Fast and decelerating reads as responsive; slow and linear reads as sluggish.
- No animation at all unless it earns its place. Respect `prefers-reduced-motion`.

**Design**

- No gradients, no glow effects, no more than one accent color per view. These are the loudest markers of AI-generated UI. Restraint reads as confidence.
- Empty states get one clear next action. A blank screen that just says "No items" is a dead end; "No items — **Create your first**" is a doorway.

**Interaction**

- Destructive actions get an `AlertDialog` — a confirm step for anything irreversible.
- Errors appear *next to where the action happened*, not in a toast across the screen.
- `h-dvh` instead of `h-screen` — `dvh` accounts for mobile browser chrome; `h-screen` is why content hides behind the URL bar on phones.
- Never block paste in inputs. (Password fields that block paste break password managers. Don't be that site.)

**Try it:** open any HTML or component file you've written — the weather project from Module 09, anything — and check it against just the typography and interaction rules by hand. Counting your own violations is the fastest way to make the rules stick.

---

## The workflow: audit, then upgrade

Here's the part that makes this a *power user* module and not a design lecture. You're going to point these skills at one of your own projects.

The order matters. The instinct is to say "make it pretty" and let the AI rewrite everything. Resist that — you'll get a different generic UI, not a better version of *yours*. The professional loop is **audit → plan → apply → verify**, and it's exactly what the skills encode:

**1. Pick a target.** One of your own projects with a UI — a web page, a React app, anything with an interface. No project with a frontend yet? Use the Module 09 weather script's output as an excuse to build one, or grab any old experiment.

**2. Install the skills there.** From that project's root: `npx ui-skills` (or copy the folders out of this repo's `.claude/skills/`).

**3. Audit first — read-only.** Start Claude Code in the project and run:

```
/improve-ui
```

This one is strict by design: it traces what actually renders, only reports problems it can *prove* against your project's own evidence, and is forbidden from touching source. It ends with a findings table and asks which ones you want plans for. Read the table. This is a design review of your work by something that has read every rule in the book — and it's the same shape as the code review you'd get on a real team.

**4. Apply the baseline.** Pick a finding (or just the worst screen) and work through it:

```
/baseline-ui src/components/YourWorstComponent.tsx
```

You'll get violations quoted line-by-line, why each matters, and a concrete fix. Apply them — yourself or by asking Claude to. **Commit before and after** (Module 08) so the diff tells the story: `git diff` is your before/after screenshot in text form.

**5. Run the targeted passes.** Each one is the same shape — point it at a file, get violations, fix, commit:

```
/fixing-accessibility src/components/Form.tsx
/fixing-motion-performance src/components/Sidebar.tsx
/fixing-metadata index.html
```

Accessibility is the one not to skip: keyboard through your whole UI (Tab, Enter, Escape) and fix what you can't reach. If the project is deployed anywhere, `/fixing-metadata` is the difference between a naked URL and a real preview card when you share the link.

**6. Look at it.** Rules catch mistakes; they don't confirm success. Open the before commit and the after commit side by side. You should see the difference — and now you'll be able to *name* it.

---

## Verify

```bash
bash modules/12-frontend-design/verify.sh
```

Then the real verification: a commit in one of your own projects whose diff shows a UI upgraded against the skills.

---

## What you can do now

You can look at an interface and name what's wrong with it — spacing off-scale, competing accents, animation on layout properties, controls a keyboard can't reach. You can install a ruleset into any project and have your AI assistant enforce it. And you know the professional loop: audit before you edit, plan before you apply, commit before and after. That loop isn't a design trick — it's how careful engineers change *anything*.

## Stretch

- Read the other four `SKILL.md` files end to end. They're short, and they're a masterclass in encoding judgment as checkable rules.
- Deploy the upgraded project (Vercel, Netlify, GitHub Pages) and check your link's preview card in a real chat app — then let `/fixing-metadata` fix what's missing.
- Write a skill of your own: create `.claude/skills/my-conventions/SKILL.md` in one of your projects and encode three rules you keep repeating to yourself. You now know the format.
- Browse the full registry at [ui-skills.com](https://www.ui-skills.com) — there are community skills for Next.js, Vue, React Native, 3D, and more.
