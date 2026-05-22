"""
ledger.py — the command-line interface.

This is the file you run. It does three things:
  1. Parse what you typed on the command line.
  2. Call the right function in another file.
  3. Print the result.

Run it:
  python ledger.py buyin alice 20
  python ledger.py cashout alice 35
  python ledger.py summary
  python ledger.py log
"""
import argparse

import storage
import display


def cmd_buyin(args):
    storage.record("buyin", args.player, args.amount)
    print(f"{args.player.title()}: buy-in ${args.amount:.2f}")


def cmd_cashout(args):
    storage.record("cashout", args.player, args.amount)
    print(f"{args.player.title()}: cash-out ${args.amount:.2f}")


def cmd_summary(args):
    events = storage.all_events()
    display.summary_table(events)


def cmd_log(args):
    events = storage.all_events()
    display.event_log(events)


def main():
    storage.init_db()

    parser = argparse.ArgumentParser(description="Poker night ledger.")
    sub = parser.add_subparsers(dest="command", required=True)

    p_buyin = sub.add_parser("buyin", help="Record a buy-in.")
    p_buyin.add_argument("player")
    p_buyin.add_argument("amount", type=float)
    p_buyin.set_defaults(func=cmd_buyin)

    p_cashout = sub.add_parser("cashout", help="Record a cash-out.")
    p_cashout.add_argument("player")
    p_cashout.add_argument("amount", type=float)
    p_cashout.set_defaults(func=cmd_cashout)

    sub.add_parser("summary", help="Show per-player totals.").set_defaults(func=cmd_summary)
    sub.add_parser("log", help="Show every event in order.").set_defaults(func=cmd_log)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
