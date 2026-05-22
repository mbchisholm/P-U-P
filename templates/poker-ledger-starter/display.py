"""
display.py — how the data looks when you print it.

This is the only file that cares about formatting. It takes events (just
plain dicts) and prints tables. If you wanted to change "$" to "€" or
swap tabulate for rich, this is the only file you'd touch.
"""
from tabulate import tabulate

import poker


def summary_table(events):
    """Per-player totals, sorted by profit/loss, with a balance check at the bottom."""
    rows = []
    for player in poker.players(events):
        rows.append([
            player.title(),
            f"${poker.total_buyin(events, player):.2f}",
            f"${poker.total_cashout(events, player):.2f}",
            f"${poker.pnl(events, player):+.2f}",
        ])
    rows.sort(key=lambda r: float(r[3].replace("$", "")), reverse=True)

    print(tabulate(rows, headers=["Player", "Buy-in", "Cash-out", "P/L"]))

    balance = poker.book_balance(events)
    if abs(balance) < 0.01:
        print("\nBooks balance.")
    else:
        print(f"\nBooks off by ${balance:+.2f} — someone's chip count was wrong.")


def event_log(events):
    """Every buy-in and cash-out in the order it happened."""
    rows = [
        [e["timestamp"], e["kind"].title(), e["player"].title(), f"${e['amount']:.2f}"]
        for e in events
    ]
    print(tabulate(rows, headers=["When", "Kind", "Player", "Amount"]))
