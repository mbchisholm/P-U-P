#!/bin/bash
# Module 12 — verify: frontend design skills installed and ready

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
echo "────────────────────────────────────"
if [ "$FAIL" -eq 0 ]; then
  echo "All checks passed. Now point the skills at one of your own projects."
else
  echo "$FAIL check(s) failed. Fix them with the hints above, then re-run."
fi
echo ""
exit "$FAIL"
