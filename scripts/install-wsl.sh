#!/bin/bash
# WSL install script — run this inside WSL after completing Module 00 → windows.md
# Installs git and base tools via apt

set -e

echo ""
echo "Power User Principles — WSL Setup"
echo "────────────────────────────────────"
echo ""

# ── apt update ───────────────────────────────────────────────────────────────
echo "→ Updating package list..."
sudo apt update -q

# ── git ─────────────────────────────────────────────────────────────────────
if command -v git &>/dev/null; then
  echo "✓ git already installed"
else
  echo "→ Installing git..."
  sudo apt install -y git
  echo "✓ git installed"
fi

# ── curl ─────────────────────────────────────────────────────────────────────
if command -v curl &>/dev/null; then
  echo "✓ curl already installed"
else
  sudo apt install -y curl
  echo "✓ curl installed"
fi

# ── build essentials (needed for pyenv) ─────────────────────────────────────
echo "→ Installing build dependencies for pyenv..."
sudo apt install -y build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev \
  xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -q
echo "✓ Build dependencies installed"

echo ""
echo "────────────────────────────────────"
echo "Core tools ready. Continue with Module 00 → windows.md"
echo ""
