#!/bin/bash
# Run this on the Pi after SSH-ing in.
# It installs everything needed to run the project.

set -e

echo "→ Updating package list..."
sudo apt-get update -qq

echo "→ Installing dependencies..."
sudo apt-get install -y -qq python3-pip python3-venv git nmap

echo "→ Cloning project..."
# Replace this URL with your own GitHub repo after Part 4
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git workshop-project
cd workshop-project/project/starter

echo "→ Setting up Python environment..."
python3 -m venv .venv
source .venv/bin/activate
pip install -q -r requirements.txt

echo ""
echo "✓ Done. To start the server:"
echo "  cd workshop-project/project/starter"
echo "  source .venv/bin/activate"
echo "  python3 app.py"
