#!/bin/bash
# Full environment check — runs all module verify scripts in sequence
# Use this for a complete status check or after a fresh clone

PASS=0
FAIL=0

section() {
  echo ""
  echo "══════════════════════════════════════"
  echo "  $1"
  echo "══════════════════════════════════════"
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
if [ -z "$REPO_ROOT" ]; then
  echo "Not inside the power-user-principles repo. cd into it first."
  exit 1
fi

section "Running all module verify scripts"

for i in 00 01 02 03 04 05 06 07 08 09 10 11; do
  VERIFY="$REPO_ROOT/modules/${i}-*/verify.sh"
  SCRIPT=$(ls $VERIFY 2>/dev/null | head -1)
  if [ -n "$SCRIPT" ]; then
    MODULE_NAME=$(basename "$(dirname "$SCRIPT")")
    echo ""
    echo "── $MODULE_NAME ──"
    if bash "$SCRIPT" 2>/dev/null; then
      PASS=$((PASS+1))
    else
      FAIL=$((FAIL+1))
    fi
  fi
done

echo ""
echo "══════════════════════════════════════"
echo "  Modules passed: $PASS  ·  Modules with issues: $FAIL"
echo "══════════════════════════════════════"
echo ""
