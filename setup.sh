#!/bin/bash
# Power User Principles — Student Machine Setup
# Run once before the workshop. Safe to run again.

set -e

PASS=0
FAIL=0

check() {
  if eval "$2" &>/dev/null; then
    echo "  ✓ $1"
    PASS=$((PASS+1))
  else
    echo "  ✗ $1 — $3"
    FAIL=$((FAIL+1))
  fi
}

echo ""
echo "Power User Principles — Setup Check"
echo "======================================"

# ── Python ─────────────────────────────────────────────────────────────────
echo ""
echo "Python"
check "python3 installed"   "command -v python3"   "Install from https://python.org"
check "python3 >= 3.11"     "python3 -c 'import sys; assert sys.version_info >= (3,11)'" \
                            "Run: brew install python@3.11"
check "pip3 installed"      "command -v pip3"      "Should come with Python 3.11"

# ── Node ────────────────────────────────────────────────────────────────────
echo ""
echo "Node / npm"
check "node installed"   "command -v node"   "Install from https://nodejs.org (LTS)"
check "node >= 18"       "node -e 'process.exit(parseInt(process.version.slice(1)) >= 18 ? 0 : 1)'" \
                         "Run: brew install node"
check "npm installed"    "command -v npm"    "Comes with Node"

# ── Tools ───────────────────────────────────────────────────────────────────
echo ""
echo "Tools"
check "git installed"   "command -v git"   "Run: xcode-select --install"
check "curl installed"  "command -v curl"  "Should be pre-installed on macOS"
check "jq installed"    "command -v jq"    "Run: brew install jq"
check "nmap installed"  "command -v nmap"  "Run: brew install nmap"

# ── Git config ──────────────────────────────────────────────────────────────
echo ""
echo "Git config"
check "git user.name set"   "git config --global user.name | grep -q '.'"  \
      "Run: git config --global user.name 'Your Name'"
check "git user.email set"  "git config --global user.email | grep -q '.'" \
      "Run: git config --global user.email 'you@example.com'"

# ── Project venv ────────────────────────────────────────────────────────────
echo ""
echo "Project"
STARTER_DIR="$(cd "$(dirname "$0")/project/starter" && pwd)"
if [ ! -d "$STARTER_DIR/.venv" ]; then
  echo "  → Creating Python venv for project/starter..."
  python3 -m venv "$STARTER_DIR/.venv"
  "$STARTER_DIR/.venv/bin/pip" install -q -r "$STARTER_DIR/requirements.txt"
  echo "  ✓ venv created and dependencies installed"
  PASS=$((PASS+1))
else
  check "project venv exists" "test -d '$STARTER_DIR/.venv'" ""
fi

# ── Summary ─────────────────────────────────────────────────────────────────
echo ""
echo "======================================"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above, then run this script again."
  exit 1
else
  echo "You're good to go."
fi
echo ""
