# Frontend Design Quick Reference

The Module 12 rules on one page. Bookmark this. See [git-quick-ref.md](git-quick-ref.md) and [shell-quick-ref.md](shell-quick-ref.md) for the other cheat sheets, and [templates/ui-starters/](../templates/ui-starters/README.md) for clean pages to copy instead of starting blank.

## The loop

| Step | Command | What it does |
|---|---|---|
| Audit a real project | `/improve-ui` | Read-only review — proven findings, touches nothing |
| Clean up a file | `/baseline-ui <file>` | The core checklist, violations quoted line-by-line |
| Accessibility pass | `/fixing-accessibility <file>` | Names, keyboard, focus, form errors |
| Motion pass | `/fixing-motion-performance <file>` | Why it stutters, what to animate instead |
| Metadata pass | `/fixing-metadata <file>` | Title, description, viewport, share cards |
| Install in your project | `npx ui-skills` | Adds the skills to any repo |

Commit before and after every pass — the diff is your before/after screenshot.

## Hierarchy & color

| Rule | Why |
|---|---|
| One accent color per view | When everything shouts, nothing is important |
| No gradients, no glow effects | The loudest markers of AI-generated UI |
| One primary action per view | The user should never guess what's next |
| Empty states get one clear next action | "No items" is a dead end; "Add your first" is a doorway |

## Typography

| Rule | Why |
|---|---|
| `text-wrap: balance` on headings, `pretty` on body | No orphaned last words |
| `tabular-nums` + right-align for numbers | Digits line up; data stops jittering |
| ~65-character measure for body text | Longer and the eye loses the line on the way back |
| Never touch `letter-spacing` without a reason | Stretched default fonts read as cheap, not elegant |

## Motion

| Rule | Why |
|---|---|
| Animate only `transform` and `opacity` | The GPU composites them; animating layout is what stutter *is* |
| Interaction feedback ≤ 200ms, `ease-out` | Fast and decelerating reads as physical; slow `ease-in` reads as sluggish |
| Never `transition: all` | You'll animate things you didn't mean to |
| Respect `prefers-reduced-motion` | Some users get motion sick; the media query costs three lines |
| No animation unless it earns its place | Motion is feedback, not decoration |

## Interaction & accessibility

| Rule | Why |
|---|---|
| Native `<button>`, `<a>`, `<input>` — never `<div onclick>` | Keyboard, focus, and announcement come free |
| `aria-label` on icon-only controls | Otherwise a screen reader announces nothing |
| Every input gets a `<label>` | Placeholders vanish exactly when you need them |
| Errors inline, next to the cause, `role="alert"` | Not a banner across the screen saying "something went wrong" |
| Confirm destructive actions with a dialog | Irreversible needs a second look |
| Never block paste | Password managers paste; so do humans |
| Tab through your UI before shipping | If the keyboard can't finish the flow, it's broken |

## Layout & metadata

| Rule | Why |
|---|---|
| Spacing from a scale (multiples of 4) | Consistency you can't get by nudging |
| `100dvh`, never `100vh` | `vh` ignores mobile browser chrome; content hides behind the URL bar |
| Always: `<title>`, meta description, viewport tag | Tab names, link previews, and phones all depend on them |
| Absolute URLs for social card images | Relative ones break in previews |

## Where the rules live

The full rulesets are files in `.claude/skills/*/SKILL.md` — readable, editable, MIT-licensed, from [ui-skills.com](https://www.ui-skills.com). Reading `baseline-ui/SKILL.md` end to end takes five minutes and covers everything above plus the React/Tailwind-specific rules.
