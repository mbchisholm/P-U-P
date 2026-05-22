"""
poker.py — what poker math means, in code.

No files. No database. No printing. Just functions that take a list of
events and answer questions about them. Pure logic — easy to read,
easy to test.

An "event" is a dict like:
  {"kind": "buyin",   "player": "alice", "amount": 20.00, "timestamp": "..."}
  {"kind": "cashout", "player": "alice", "amount": 35.00, "timestamp": "..."}
"""


def players(events):
    """Every name that ever bought in or cashed out, in sorted order."""
    names = {e["player"] for e in events}
    return sorted(names)


def total_buyin(events, player):
    """How much this player put in (across all their buy-ins)."""
    return sum(e["amount"] for e in events if e["player"] == player and e["kind"] == "buyin")


def total_cashout(events, player):
    """How much this player took out (across all their cash-outs)."""
    return sum(e["amount"] for e in events if e["player"] == player and e["kind"] == "cashout")


def pnl(events, player):
    """Profit or loss for one player. Positive = up. Negative = down."""
    return total_cashout(events, player) - total_buyin(events, player)


def book_balance(events):
    """
    Total money out minus total money in. Should be zero — every dollar
    that came in should leave with someone. Anything else means a chip
    count was off or a buy-in/cash-out got recorded wrong.
    """
    money_in = sum(e["amount"] for e in events if e["kind"] == "buyin")
    money_out = sum(e["amount"] for e in events if e["kind"] == "cashout")
    return money_out - money_in
