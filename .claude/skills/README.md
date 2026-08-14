# UI Skills (vendored)

These six skills come from [UI Skills](https://www.ui-skills.com) by [Julien Thibeaut (@ibelick)](https://github.com/ibelick/ui-skills), vendored from the `ui-skills` npm package (v0.2.4, MIT licensed — see [LICENSE](LICENSE)).

Because they live in this repo's `.claude/skills/`, any Claude Code session started inside this repo has them available automatically:

| Skill | Invoke | What it does |
|-------|--------|--------------|
| [ui-skills-root](ui-skills-root/SKILL.md) | `/ui-skills-root` | Routing layer — picks the smallest useful skill for a UI task |
| [baseline-ui](baseline-ui/SKILL.md) | `/baseline-ui` | The opinionated baseline: spacing, hierarchy, typography, motion rules |
| [improve-ui](improve-ui/SKILL.md) | `/improve-ui` | Read-only audit of an existing surface; produces evidence-backed findings and plans |
| [fixing-accessibility](fixing-accessibility/SKILL.md) | `/fixing-accessibility` | ARIA labels, keyboard access, focus, forms, contrast |
| [fixing-motion-performance](fixing-motion-performance/SKILL.md) | `/fixing-motion-performance` | Janky animations: compositor props, layout thrash, scroll-linked motion |
| [fixing-metadata](fixing-metadata/SKILL.md) | `/fixing-metadata` | Titles, descriptions, canonical URLs, Open Graph / social cards |

To install them in **your own** projects, run `npx ui-skills` from the project root — see [Module 12](../../modules/12-frontend-design/README.md).
