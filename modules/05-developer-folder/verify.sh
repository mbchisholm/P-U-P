#!/bin/bash
# Module 05 — verify: Developer folder structure exists

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
echo "Module 05 — Developer Folder"
echo "────────────────────────────────────"

echo ""
check "~/Developer exists" "test -d ~/Developer" \
  "Run: mkdir -p ~/Developer"
check "repo is inside ~/Developer" \
  "git rev-parse --show-toplevel 2>/dev/null | grep -q 'Developer'" \
  "Clone or move the repo into ~/Developer/<org>/<repo>"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 06."
fi
echo ""
