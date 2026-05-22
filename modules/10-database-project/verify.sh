#!/bin/bash
# Module 10 — verify: SQLite project exists and runs

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

PROJECT_DIR="$(git rev-parse --show-toplevel 2>/dev/null)/modules/10-database-project/ledger"

echo ""
echo "Module 10 — Database Project"
echo "────────────────────────────────────"

echo ""
echo "Project structure"
check "ledger/ directory exists" "test -d '$PROJECT_DIR'" \
  "Run: mkdir -p modules/10-database-project/ledger"
check "ledger.py exists" "test -f '$PROJECT_DIR/ledger.py'" \
  "Create ledger.py as shown in the module"
check "ledger.db not tracked by git" \
  "! git ls-files --error-unmatch '$PROJECT_DIR/ledger.db' 2>/dev/null" \
  "Run: git rm --cached modules/10-database-project/ledger/ledger.db && echo 'ledger.db' >> .gitignore"

echo ""
echo "Python"
check "sqlite3 available" "python3 -c 'import sqlite3'" \
  "sqlite3 is part of Python's standard library — check your Python installation"
check "argparse available" "python3 -c 'import argparse'" ""

echo ""
echo "App runs"
check "ledger.py runs without error" \
  "cd '$PROJECT_DIR' && python3 ledger.py summary" \
  "Run: cd modules/10-database-project/ledger && python3 ledger.py summary"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 11."
fi
echo ""
