#!/bin/bash
# Module 00 — verify: shell ready, git configured, repo cloned

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
echo "Module 00 — Start Here"
echo "────────────────────────────────────"

echo ""
echo "Shell"
check "bash or zsh available" "command -v bash || command -v zsh" "Should be installed by default"

echo ""
echo "Git"
check "git installed" "command -v git" "macOS: xcode-select --install  |  WSL: sudo apt install git"
check "git user.name set" "git config --global user.name | grep -q '.'" \
  "Run: git config --global user.name 'Your Name'"
check "git user.email set" "git config --global user.email | grep -q '.'" \
  "Run: git config --global user.email 'you@email.com'"

echo ""
echo "Repo"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
check "inside git repo" "git rev-parse --show-toplevel" \
  "cd into the power-user-principles folder and run this again"
check "modules/ directory exists" "test -d '${REPO_ROOT}/modules'" \
  "You may not have cloned the right repo, or something went wrong"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 01."
fi
echo ""
