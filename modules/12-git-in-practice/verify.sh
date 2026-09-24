#!/bin/bash
# Module 12 — verify: git identity, sane defaults, and a repo you've actually pushed

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

echo ""
echo "Module 12 — Git in Practice"
echo "────────────────────────────────────"

echo ""
echo "Identity"
check "git user.name set" "git config --get user.name" \
  "Run: git config --global user.name 'Your Name'"
check "git user.email set" "git config --get user.email" \
  "Run: git config --global user.email 'you@email.com'"

echo ""
echo "Defaults"
check "new repos default to 'main'" \
  "[ \"\$(git config --get init.defaultBranch)\" = 'main' ]" \
  "Run: git config --global init.defaultBranch main"
check "pull strategy configured" \
  "git config --get pull.rebase || git config --get pull.ff" \
  "Run: git config --global pull.rebase false  — without this, 'git pull' aborts when branches diverge"

echo ""
echo "This repo"
check "inside a git repo" "git rev-parse --show-toplevel" \
  "cd into the power-user-principles directory"
check "remote 'origin' configured" "git remote get-url origin" \
  "Run: git remote add origin git@github.com:yourusername/repo.git"
check "current branch tracks a remote branch" \
  "git rev-parse --abbrev-ref --symbolic-full-name @{u}" \
  "You haven't pushed this branch yet. Run: git push -u origin \$(git branch --show-current)"

echo ""
echo "GitHub"
check "GitHub SSH authentication works" \
  "ssh -T git@github.com 2>&1 | grep -q 'successfully authenticated'" \
  "Redo Module 04 — your key isn't reaching GitHub"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "Module 12 complete. Keep reference/git-decisions.md open while you work."
fi
echo ""
