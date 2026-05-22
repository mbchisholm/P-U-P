#!/bin/bash
# Module 06 — verify: Python, Node, git tooling installed

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
echo "Module 06 — Tooling"
echo "────────────────────────────────────"

echo ""
echo "Python"
check "python available" "command -v python || command -v python3" \
  "Install pyenv and run: pyenv install 3.12.3 && pyenv global 3.12.3"
check "python >= 3.11" \
  "(python --version 2>/dev/null || python3 --version 2>/dev/null) | grep -E 'Python 3\.(1[1-9]|[2-9][0-9])'" \
  "Run: pyenv install 3.12.3 && pyenv global 3.12.3"
check "pip available" "command -v pip || command -v pip3" \
  "pip should come with Python"

echo ""
echo "Node"
check "node available" "command -v node" \
  "Install nvm and run: nvm install --lts && nvm use --lts"
check "node >= 18" \
  "node -e 'process.exit(parseInt(process.version.slice(1)) >= 18 ? 0 : 1)'" \
  "Run: nvm install --lts && nvm use --lts"
check "npm available" "command -v npm" \
  "npm comes with node"

echo ""
echo "Git"
check "git installed" "command -v git" ""
check "git user.name set" "git config --global user.name | grep -q '.'" \
  "Run: git config --global user.name 'Your Name'"
check "git user.email set" "git config --global user.email | grep -q '.'" \
  "Run: git config --global user.email 'your@email.com'"
check "git default branch is main" "git config --global init.defaultBranch | grep -q 'main'" \
  "Run: git config --global init.defaultBranch main"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 07."
fi
echo ""
