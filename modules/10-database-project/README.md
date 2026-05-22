# Module 10 — A Tiny Database

> **You'll be able to:** Build a CLI app that stores data in a SQLite database and queries it back.
> **Time:** ~60 min
> **Prereqs:** Module 08

## Why this matters

Most apps need to remember things. A database is how software persists state across runs — not in a file you read and write manually, but in a structured store you query with SQL. SQLite is the right starting point: it's a full SQL database in a single file, no server required, no setup beyond the standard library. Once you understand it, the jump to PostgreSQL or MySQL is just a matter of scale.

## Setup

```bash
cd ~/Developer/power-user-principles
mkdir -p modules/10-database-project/ledger
cd modules/10-database-project/ledger
```

---

## What We're Building

A poker session tracker. You log sessions (buy-in, cash-out, date), and query your running totals.

```
$ python ledger.py add --buyin 100 --cashout 185
Session added: +$85

$ python ledger.py add --buyin 50 --cashout 30
Session added: -$20

$ python ledger.py summary
Sessions:  2
Total P/L: +$65
Best:      +$85
Worst:     -$20
```

---

## SQLite Basics

SQLite stores data in a single `.db` file. No server. No installation. Python includes it in the standard library.

```python
import sqlite3

conn = sqlite3.connect("ledger.db")   # creates the file if it doesn't exist
cursor = conn.cursor()
```

SQL (Structured Query Language) is how you talk to it:

```sql
CREATE TABLE sessions (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    date    TEXT NOT NULL,
    buyin   INTEGER NOT NULL,
    cashout INTEGER NOT NULL
);

INSERT INTO sessions (date, buyin, cashout) VALUES ('2024-05-21', 100, 185);

SELECT * FROM sessions;

SELECT SUM(cashout - buyin) AS total_pnl FROM sessions;
```

---

## Build the App

There's a starter with TODOs in `demo/ledger-starter.py` if you want a scaffold to fill in rather than typing from scratch. The complete solution is below.

Create `ledger.py`:

```python
import sqlite3
import argparse
from datetime import date

DB_PATH = "ledger.db"

def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    with get_connection() as conn:
        conn.execute("""
            CREATE TABLE IF NOT EXISTS sessions (
                id      INTEGER PRIMARY KEY AUTOINCREMENT,
                date    TEXT NOT NULL,
                buyin   INTEGER NOT NULL,
                cashout INTEGER NOT NULL
            )
        """)

def add_session(buyin, cashout):
    today = date.today().isoformat()
    pnl = cashout - buyin
    with get_connection() as conn:
        conn.execute(
            "INSERT INTO sessions (date, buyin, cashout) VALUES (?, ?, ?)",
            (today, buyin, cashout),
        )
    sign = "+" if pnl >= 0 else ""
    print(f"Session added: {sign}${pnl}")

def summary():
    with get_connection() as conn:
        rows = conn.execute("SELECT buyin, cashout FROM sessions").fetchall()
    if not rows:
        print("No sessions recorded.")
        return
    pnls = [r["cashout"] - r["buyin"] for r in rows]
    total = sum(pnls)
    sign = "+" if total >= 0 else ""
    print(f"Sessions:  {len(pnls)}")
    print(f"Total P/L: {sign}${total}")
    print(f"Best:      +${max(pnls)}")
    print(f"Worst:     ${min(pnls)}")

def main():
    init_db()
    parser = argparse.ArgumentParser(description="Poker session ledger")
    subparsers = parser.add_subparsers(dest="command")

    add_parser = subparsers.add_parser("add", help="Log a session")
    add_parser.add_argument("--buyin", type=int, required=True)
    add_parser.add_argument("--cashout", type=int, required=True)

    subparsers.add_parser("summary", help="Show totals")

    args = parser.parse_args()

    if args.command == "add":
        add_session(args.buyin, args.cashout)
    elif args.command == "summary":
        summary()
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
```

---

## Run It

```bash
python ledger.py add --buyin 100 --cashout 185
python ledger.py add --buyin 50 --cashout 30
python ledger.py summary
```

---

## Inspect the Database

The data is in `ledger.db` — a real file on disk. You can open it with the `sqlite3` command:

```bash
sqlite3 ledger.db
```

Inside the SQLite prompt:
```sql
.tables
SELECT * FROM sessions;
.quit
```

The file survives program restarts. That's the point: state that persists.

**Check:**
```bash
ls -lh ledger.db    # should show a small file
```

---

## .gitignore

The database file is data, not code. Don't commit it.

```bash
echo "ledger.db" >> .gitignore
```

---

## Commit

```bash
git add ledger.py .gitignore
git commit -m "add poker ledger CLI with SQLite backend"
git push
```

---

## Verify

```bash
bash modules/10-database-project/verify.sh
```

---

## What you can do now

You can persist data and read it back later. You understand the difference between data (the database file) and code (the Python script). You know how SQL inserts and queries work. This is the foundation of every app that remembers anything.

## Stretch

- Add a `list` command that shows all sessions with their dates and P&L
- Add a `--date` argument to `add` that lets you log a past session
- Ask Claude Code to add a `reset` command that deletes all sessions (with a confirmation prompt)
- Replace `sqlite3` with `SQLAlchemy` — same result, but you'll see how an ORM abstracts the SQL away

## Going further

You built this as one file because one file is enough to learn from. Real codebases are split into many. The same poker ledger, broken into four files — each one with one obvious job — lives at [`templates/poker-ledger-starter/`](../../templates/poker-ledger-starter/README.md):

```
ledger.py    ← CLI: parses args, dispatches
poker.py     ← pure math: per-player P/L, book balance
storage.py   ← SQLite: the only file that knows SQL
display.py   ← formatting: the only file that knows tabulate
```

It also adds the features you'd want for an actual poker night: multiple players, multiple buy-ins per player, and a book-balance check that catches bad chip counts. Read it after you've finished this module. Try the "going further" exercises in its README — most of them are about *keeping the four files honest about their jobs* as you change things.
