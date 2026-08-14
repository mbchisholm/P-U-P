#!/bin/bash
# Module 12 — verify: skills installed, demo page actually deslopped

PASS=0
FAIL=0

check() {
  local label="$1"
  local cmd="$2"
  local hint="$3"
  if eval "$cmd" &>/dev/null; then
    printf "  \033[32m✓\033[0m %s\n" "$label"
    PASS=$((PASS+1))
  else
    printf "  \033[31m✗\033[0m %s\n" "$label"
    [ -n "$hint" ] && printf "    → %s\n" "$hint"
    FAIL=$((FAIL+1))
  fi
}

REPO_DIR="$(git rev-parse --show-toplevel 2>/dev/null)"
SKILLS_DIR="$REPO_DIR/.claude/skills"
PAGE="$REPO_DIR/modules/12-frontend-design/demo/slop.html"

echo ""
echo "Module 12 — Frontend Design"
echo "────────────────────────────────────"

echo ""
echo "Tooling"
check "node is installed" "command -v node" \
  "Module 06 covers installing Node"
check "npx is available" "command -v npx" \
  "npx ships with Node — reinstall Node from Module 06"

echo ""
echo "UI Skills installed in this repo"
for skill in ui-skills-root baseline-ui improve-ui fixing-accessibility fixing-motion-performance fixing-metadata; do
  check "$skill" "test -f '$SKILLS_DIR/$skill/SKILL.md'" \
    "Re-pull the repo: git pull — the skills ship in .claude/skills/"
done

echo ""
echo "The demo page (fails until you finish Part 3)"
check "demo/slop.html exists" "test -f '$PAGE'" \
  "Reset it: git checkout -- modules/12-frontend-design/demo/slop.html"
check "no gradients left" "! grep -q 'linear-gradient' '$PAGE'" \
  "Run /baseline-ui demo/slop.html — one accent color, no gradients"
check "no letter-spacing hacks" "! grep -q 'letter-spacing' '$PAGE'" \
  "Run /baseline-ui demo/slop.html — never touch letter-spacing without a reason"
check "no 'transition: all' animations" "! grep -Eq 'transition:[[:space:]]*all' '$PAGE'" \
  "Run /fixing-motion-performance demo/slop.html — animate transform/opacity, briefly"
check "no 100vh (mobile browsers hide content)" "! grep -q '100vh' '$PAGE'" \
  "Run /baseline-ui demo/slop.html — use 100dvh"
check "no div-as-button" "! grep -Eq '<div[^>]*onclick' '$PAGE'" \
  "Run /fixing-accessibility demo/slop.html — real <button> elements get keyboard support free"
check "icon buttons have aria-label" "grep -q 'aria-label' '$PAGE'" \
  "Run /fixing-accessibility demo/slop.html — icon-only buttons need an accessible name"
check "inputs have <label> elements" "grep -qi '<label' '$PAGE'" \
  "Run /fixing-accessibility demo/slop.html — placeholders are not labels"
check "paste is not blocked" "! grep -qi 'onpaste' '$PAGE'" \
  "Run /baseline-ui demo/slop.html — never block paste in inputs"
check "page has a <title>" "grep -qi '<title>' '$PAGE'" \
  "Run /fixing-metadata demo/slop.html"
check "page has a meta description" "grep -qi 'name=\"description\"' '$PAGE'" \
  "Run /fixing-metadata demo/slop.html"
check "page has a viewport tag" "grep -qi 'name=\"viewport\"' '$PAGE'" \
  "Run /fixing-metadata demo/slop.html — without it, phones render the page zoomed out"

echo ""
echo "────────────────────────────────────"
if [ "$FAIL" -eq 0 ]; then
  echo "All checks passed. Now point the skills at one of your own projects (Part 4)."
else
  echo "$FAIL check(s) failed. The hints name the skill that fixes each one."
fi
echo ""
exit "$FAIL"
