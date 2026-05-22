#!/bin/bash
# Module 07 — verify: terminal config and quality-of-life tools

PASS=0
FAIL=0
WARN=0

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

warn() {
  local label="$1"
  local cmd="$2"
  local hint="$3"
  if eval "$cmd" &>/dev/null; then
    printf "  \033[32m✓\033[0m %s\n" "$label"
    PASS=$((PASS+1))
  else
    printf "  \033[33m~\033[0m %s (optional)\n" "$label"
    [ -n "$hint" ] && printf "    → %s\n" "$hint"
    WARN=$((WARN+1))
  fi
}

echo ""
echo "Module 07 — Terminal Config"
echo "────────────────────────────────────"

echo ""
echo "Shell config"
if [[ "$OSTYPE" == "darwin"* ]]; then
  check "~/.zshrc exists" "test -f ~/.zshrc" \
    "Create it: touch ~/.zshrc"
  check "shell config has aliases" "grep -q 'alias' ~/.zshrc" \
    "Add aliases to ~/.zshrc as shown in the module"
else
  check "~/.bashrc exists" "test -f ~/.bashrc" \
    "Create it: touch ~/.bashrc"
  check "shell config has aliases" "grep -q 'alias' ~/.bashrc" \
    "Add aliases to ~/.bashrc as shown in the module"
fi

echo ""
echo "Tools"
warn "bat installed" "command -v bat || command -v batcat" \
  "macOS: brew install bat  |  WSL: sudo apt install bat"
warn "glow installed" "command -v glow" \
  "macOS: brew install glow  |  WSL: sudo apt install glow"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed  ·  $WARN optional not installed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the required items above and run this again."
  exit 1
else
  echo "You're ready for Module 08."
fi
echo ""
