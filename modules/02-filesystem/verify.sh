#!/bin/bash
# Module 02 — verify: filesystem navigation and file operations

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
echo "Module 02 — The File System"
echo "────────────────────────────────────"

echo ""
echo "Commands"
check "ls works" "ls ~ | grep -q '.'" ""
check "pwd works" "pwd | grep -q '/'" ""
check "mkdir works" "mkdir -p /tmp/pup-test-02 && rmdir /tmp/pup-test-02" ""
check "touch works" "touch /tmp/pup-test-02-file && rm /tmp/pup-test-02-file" ""
check "find works" "command -v find" ""
check "grep works" "command -v grep" ""

echo ""
echo "File system structure"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
check "Developer folder exists" "test -d ~/Developer" \
  "Run: mkdir -p ~/Developer"
check "modules/ directory present" "test -d '${REPO_ROOT}/modules'" \
  "Are you running this from inside the repo?"

echo ""
echo "Pipes"
check "pipe with grep works" "ls / | grep -q 'usr'" ""
check "wc available" "command -v wc" ""

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 03."
fi
echo ""
