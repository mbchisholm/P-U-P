#!/bin/bash
# Module 03 — verify: processes, permissions, networking basics

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
echo "Module 03 — Processes, Permissions, Networks"
echo "────────────────────────────────────"

echo ""
echo "Processes"
check "ps available" "command -v ps" ""
check "kill available" "command -v kill" ""

echo ""
echo "Permissions"
check "chmod available" "command -v chmod" ""
check "ls -la works" "ls -la ~ | grep -q 'rwx\|rw-'" ""

echo ""
echo "Networking"
if [[ "$OSTYPE" == "darwin"* ]]; then
  check "can get IP address (macOS)" \
    "ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null" \
    "Connect to WiFi and try again"
else
  check "ip command available (Linux/WSL)" "command -v ip" \
    "Run: sudo apt install iproute2"
fi
check "ping available" "command -v ping" ""
check "internet reachable" "ping -c 1 -W 3 8.8.8.8" \
  "Check your network connection"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 04."
fi
echo ""
