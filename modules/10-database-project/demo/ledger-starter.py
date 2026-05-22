"""
ledger-starter.py — skeleton for Module 10.

Copy this to modules/10-database-project/ledger/ledger.py and fill in the TODOs.
The README shows the complete solution if you get stuck.
"""
import sqlite3
import argparse
from datetime import date

DB_PATH = "ledger.db"


def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    # TODO: use get_connection() to create the sessions table if it doesn't exist
    # Columns: id (INTEGER PRIMARY KEY AUTOINCREMENT), date (TEXT NOT NULL),
    #          buyin (INTEGER NOT NULL), cashout (INTEGER NOT NULL)
    pass


def add_session(buyin, cashout):
    today = date.today().isoformat()
    # TODO: insert (today, buyin, cashout) into the sessions table
    # TODO: calculate pnl = cashout - buyin
    # TODO: print "Session added: +$85" (or -$20 for a loss)
    pass


def summary():
    # TODO: fetch all sessions, compute total P/L, best, and worst
    # TODO: print the summary block as shown in the module README
    # Handle the case where there are no sessions yet
    pass


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
