#!/bin/bash
# Module 08 — verify: VS Code installed, git workflow working

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
echo "Module 08 — IDE & Git Workflow"
echo "────────────────────────────────────"

echo ""
echo "VS Code"
check "code command available" "command -v code" \
  "macOS: install shell command from VS Code command palette (cmd+shift+p → 'shell command')"

echo ""
echo "Git"
check "git installed" "command -v git" ""
check "inside a git repo" "git rev-parse --show-toplevel" \
  "cd into the power-user-principles directory"
check "repo has at least one commit" "git log --oneline | head -1 | grep -q '.'" \
  "Make a commit first"
check ".gitignore exists" "test -f .gitignore" \
  "Create one: touch .gitignore"

echo ""
echo "GitHub"
check "git remote configured" "git remote get-url origin" \
  "Run: git remote add origin git@github.com:yourusername/repo.git"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 09."
fi
echo ""
