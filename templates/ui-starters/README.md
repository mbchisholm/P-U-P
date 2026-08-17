# UI Starters

Four clean, self-contained pages you can copy as the starting point for real projects. No build step, no dependencies — each is one HTML file that opens with a double-click and follows every rule from [Module 12](../../modules/12-frontend-design/README.md).

**The point of starting from these instead of a blank file:** a blank file invites improvisation, and improvisation is where slop comes from. These pages already have the decisions made — one accent, a spacing scale, real buttons, labeled inputs, fast `ease-out` motion on `transform` only, `tabular-nums` on data, metadata filled in. You change the content and the theme; the structure keeps you honest.

## What's here

| File | Use it for |
|------|-----------|
| [`landing.html`](landing.html) | A marketing page: nav, hero, three feature cards, closing CTA |
| [`dashboard.html`](dashboard.html) | An app shell: sidebar nav, stat cards, data table with status badges |
| [`form.html`](form.html) | Any form: labels, hints, inline errors done right (the pattern most worth stealing) |
| [`article.html`](article.html) | Long-form reading: docs, blog posts, notes — typography does all the work |
| [`blog-index.html`](blog-index.html) | A blog front page: kicker-above-title post cards, **light/dark themes** |
| [`blog-post.html`](blog-post.html) | The matching post page: contents panel, reading surface, post-to-post nav |

## How to reuse one

1. **Copy the file** into your project and rename it.
2. **Change the words**: `<title>`, meta description, and the placeholder copy.
3. **Re-theme via the tokens.** Every page starts with the same `:root` block — the entire look is parameterized there:

```css
:root {
  --accent: #4f46e5;   /* the ONE accent color — change this first */
  --accent-dark: #4338ca;
  --ink: #1a1a1a;      /* text */
  --muted: #6b7280;    /* secondary text */
  --line: #e5e7eb;     /* borders */
  --bg: #ffffff;
  --surface: #f9fafb;  /* panels, code blocks */
  --radius: 8px;
  --font: -apple-system, "Segoe UI", Roboto, sans-serif;
}
```

Change `--accent` (and its hover shade `--accent-dark`) and the whole page follows — that's what "design tokens" means, and it's the same idea Tailwind and every design system scale up. Because all four pages share the block, you can theme them together and they'll read as one product.

4. **Check yourself** with the skills: `/baseline-ui yourpage.html` should come back clean. If you've edited heavily, run `/fixing-accessibility` and `/fixing-metadata` too.

## Dark mode is just tokens twice

The blog pair shows the full dark-mode pattern, and it costs almost nothing once you have tokens:

1. Redefine the same tokens under `html.dark` — different values, same names. No other CSS changes.
2. A three-line script in `<head>` applies the saved theme **before paint** (no flash of the wrong theme), defaulting to the visitor's `prefers-color-scheme`.
3. A toggle button flips the class and saves the choice to `localStorage`.

If your colors are hard-coded anywhere outside the token block, dark mode means hunting them all down. If they're tokens, dark mode is one extra block. This is the strongest argument for tokens there is.

## A real site running this pattern

These starters aren't hypothetical: the [half-measure](https://github.com/mbchisholm/half-measure) blog (Astro) runs this exact system — same token names, same kicker-above-title cards, same surface-panel contents box, re-themed warm paper/copper instead of the default indigo. Diff its `src/styles/global.css` token block against a starter's to see how far a re-theme alone can move the identity.

## Mixing pages

The starters compose: `landing.html` for the front door, `form.html` for sign-up, `dashboard.html` once the user is in, `article.html` for the docs. Keep the token block identical across them and the seams disappear.

## Rules these pages bake in

If you edit structure (not just content), keep these — they're why the pages look designed:

- One accent color per view; everything else is ink, muted, or a line.
- Spacing on a scale (multiples of 4px), never nudged values.
- Real `<button>` and `<label>` elements; `aria-label` on icon-only controls.
- Errors inline, next to the field, with `role="alert"` — never a banner far away.
- Motion: `transform`/`background-color` only, ≤200ms, `ease-out`, honored `prefers-reduced-motion`.
- `text-wrap: balance` on headings, `pretty` on paragraphs, `tabular-nums` on numbers.
- `100dvh` not `100vh`; title, description, and viewport always present.

The full checklist lives in [reference/frontend-design-quick-ref.md](../../reference/frontend-design-quick-ref.md).
