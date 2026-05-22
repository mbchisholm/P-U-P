#!/bin/bash
# Module 11 — verify: SSH key setup and Pi connectivity

PASS=0
FAIL=0
SKIP=0

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
echo "Module 11 — SSH Into a Pi"
echo "────────────────────────────────────"

echo ""
echo "SSH prerequisites"
check "SSH key exists" \
  "test -f ~/.ssh/id_ed25519 || test -f ~/.ssh/id_rsa" \
  "Complete Module 04 first"
check "ssh client available" "command -v ssh" ""
check "nmap available" "command -v nmap" \
  "macOS: brew install nmap  |  WSL: sudo apt install nmap"

echo ""
echo "Pi connectivity"
PI_HOST="${PI_HOST:-raspberrypi.local}"

if ping -c 1 -W 2 "$PI_HOST" &>/dev/null; then
  printf "  \033[32m✓\033[0m Pi is reachable at %s\n" "$PI_HOST"
  PASS=$((PASS+1))

  if ssh -o ConnectTimeout=5 -o BatchMode=yes "pi@$PI_HOST" exit 2>/dev/null; then
    printf "  \033[32m✓\033[0m SSH key authentication works\n"
    PASS=$((PASS+1))
  else
    printf "  \033[31m✗\033[0m SSH key authentication failed\n"
    printf "    → Run: ssh-copy-id pi@%s\n" "$PI_HOST"
    FAIL=$((FAIL+1))
  fi
else
  printf "  \033[33m~\033[0m Pi not reachable at %s (set PI_HOST=<ip> to override)\n" "$PI_HOST"
  printf "    → Connect the Pi to WiFi and try again, or check the IP with: bash scan.sh\n"
  SKIP=$((SKIP+1))
fi

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed  ·  $SKIP skipped (Pi not found)"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
elif [ $SKIP -gt 0 ]; then
  echo "Prerequisites check passed. Connect the Pi and run this again to verify SSH."
else
  echo "Module 11 complete. You can SSH into the Pi."
fi
echo ""
