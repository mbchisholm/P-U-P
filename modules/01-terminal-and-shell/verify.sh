#!/bin/bash
# Module 01 — verify: shell basics understood

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
echo "Module 01 — Terminal & Shell"
echo "────────────────────────────────────"

echo ""
echo "Shell"
check "echo works" "echo test | grep -q test" "Something is very wrong"
check "PATH is set" 'echo "$PATH" | grep -q "/"' "PATH should contain /usr/bin at minimum"
check "which works" "which ls | grep -q ls" "which ls should return a path"

echo ""
echo "Tools"
check "man is available" "command -v man" "man should be pre-installed"
check "history command works" "history | head -1 | grep -q '.'" "Try running a few commands first"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 02."
fi
echo ""
