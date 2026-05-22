#!/bin/bash
# Module 04 — verify: SSH key generated and GitHub connected

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
echo "Module 04 — SSH Keys & GitHub"
echo "────────────────────────────────────"

echo ""
echo "SSH Key"
check "~/.ssh directory exists" "test -d ~/.ssh" \
  "Run: ssh-keygen -t ed25519 -C 'your@email.com'"
check "private key exists" "test -f ~/.ssh/id_ed25519 || test -f ~/.ssh/id_rsa || test -f ~/.ssh/id_ecdsa" \
  "Run: ssh-keygen -t ed25519 -C 'your@email.com'"
check "public key exists" "test -f ~/.ssh/id_ed25519.pub || test -f ~/.ssh/id_rsa.pub || test -f ~/.ssh/id_ecdsa.pub" \
  "Your private key exists but the .pub file is missing — something went wrong during keygen"

echo ""
echo "GitHub"
check "GitHub SSH authentication works" \
  "ssh -T git@github.com 2>&1 | grep -q 'successfully authenticated'" \
  "Follow the 'Add the Key to GitHub' steps in the module README"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 05."
fi
echo ""
