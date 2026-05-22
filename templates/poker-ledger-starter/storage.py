"""
storage.py — where the data lives.

Every event (buy-in or cash-out) is a row in a SQLite table. The
database is a single file on disk called `ledger.db` — you can open it
with the `sqlite3` command-line tool and look at your data directly.

This file knows about SQL. Nothing else in the project does.
"""
import sqlite3
from datetime import datetime

DB_PATH = "ledger.db"


def _connect():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    """Create the events table on first run. Safe to call every time."""
    with _connect() as conn:
        conn.execute("""
            CREATE TABLE IF NOT EXISTS events (
                id        INTEGER PRIMARY KEY AUTOINCREMENT,
                kind      TEXT    NOT NULL CHECK (kind IN ('buyin', 'cashout')),
                player    TEXT    NOT NULL,
                amount    REAL    NOT NULL,
                timestamp TEXT    NOT NULL
            )
        """)


def record(kind, player, amount):
    """Insert one buy-in or cash-out."""
    timestamp = datetime.now().isoformat(timespec="seconds")
    with _connect() as conn:
        conn.execute(
            "INSERT INTO events (kind, player, amount, timestamp) VALUES (?, ?, ?, ?)",
            (kind, player.lower(), amount, timestamp),
        )


def all_events():
    """Return every event as a list of plain dicts, oldest first."""
    with _connect() as conn:
        rows = conn.execute("SELECT * FROM events ORDER BY id").fetchall()
    return [dict(r) for r in rows]
