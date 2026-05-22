#!/bin/bash
# shell-loop.sh — a tiny script that shows the shell loop in action.
#
# Run it: bash modules/01-terminal-and-shell/demo/shell-loop.sh
#
# Every command here is something you could type manually.
# A script is just those commands saved in a file.

echo "=== What shell am I in? ==="
echo $SHELL

echo ""
echo "=== Where am I? ==="
pwd

echo ""
echo "=== What's in PATH? (colon-separated directories) ==="
echo $PATH | tr ':' '\n'

echo ""
echo "=== Where does 'ls' live? ==="
which ls

echo ""
echo "=== What's running right now? (this script is one of them) ==="
ps | head -5

echo ""
echo "=== Done. Every line above was a program the shell found and ran. ==="
