#!/bin/bash
# Mac install script — run this once in Module 00 (Mac path)
# Installs Homebrew, then you handle the rest per-module

set -e

echo ""
echo "Power User Principles — Mac Setup"
echo "────────────────────────────────────"
echo ""

# ── Homebrew ────────────────────────────────────────────────────────────────
if command -v brew &>/dev/null; then
  echo "✓ Homebrew already installed"
else
  echo "→ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✓ Homebrew installed"
  echo ""
  echo "⚠  If you're on Apple Silicon (M1/M2/M3/M4), run the two commands"
  echo "   Homebrew just printed above, then open a new terminal window."
  echo "   Come back and re-run this script to verify everything is set."
  exit 0
fi

# ── git ─────────────────────────────────────────────────────────────────────
if command -v git &>/dev/null; then
  echo "✓ git already installed"
else
  echo "→ Installing git via xcode-select..."
  xcode-select --install
  echo "  (Follow the dialog that appeared. Re-run this script when done.)"
  exit 0
fi

echo ""
echo "────────────────────────────────────"
echo "Core tools ready. Continue with Module 00 → mac.md"
echo ""
