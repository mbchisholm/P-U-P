#!/bin/bash
# Module 09 — verify: API project setup and working script

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

PROJECT_DIR="$(git rev-parse --show-toplevel 2>/dev/null)/modules/09-api-project/weather"

echo ""
echo "Module 09 — API Project"
echo "────────────────────────────────────"

echo ""
echo "Project structure"
check "weather/ directory exists" "test -d '$PROJECT_DIR'" \
  "Run: mkdir -p modules/09-api-project/weather"
check "weather.py exists" "test -f '$PROJECT_DIR/weather.py'" \
  "Create weather.py as shown in the module"
check ".env exists" "test -f '$PROJECT_DIR/.env'" \
  "Create .env with your OPENWEATHER_API_KEY"
check ".gitignore includes .env" "grep -q '.env' '$PROJECT_DIR/.gitignore' 2>/dev/null || grep -q '.env' '$(git rev-parse --show-toplevel 2>/dev/null)/.gitignore'" \
  "Run: echo '.env' >> .gitignore"
check ".env is not tracked by git" \
  "! git ls-files --error-unmatch '$PROJECT_DIR/.env' 2>/dev/null" \
  "IMPORTANT: run 'git rm --cached modules/09-api-project/weather/.env' immediately"

echo ""
echo "Python environment"
check "virtual env exists" "test -d '$PROJECT_DIR/.venv'" \
  "Run: cd modules/09-api-project/weather && python -m venv .venv"
check "requests installed" \
  "'$PROJECT_DIR/.venv/bin/pip' show requests 2>/dev/null || pip show requests 2>/dev/null" \
  "Activate venv and run: pip install requests python-dotenv"
check "python-dotenv installed" \
  "'$PROJECT_DIR/.venv/bin/pip' show python-dotenv 2>/dev/null || pip show python-dotenv 2>/dev/null" \
  "Activate venv and run: pip install requests python-dotenv"
check "requirements.txt exists" "test -f '$PROJECT_DIR/requirements.txt'" \
  "Run: pip freeze > requirements.txt"

echo ""
echo "────────────────────────────────────"
echo "  $PASS passed  ·  $FAIL failed"
echo ""

if [ $FAIL -gt 0 ]; then
  echo "Fix the items above and run this again."
  exit 1
else
  echo "You're ready for Module 10."
fi
echo ""
