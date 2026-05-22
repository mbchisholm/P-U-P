# Poker Ledger — Modular Version

In Module 10 you built a poker ledger as a single Python file. This is the same idea — record buy-ins and cash-outs, see who's up — but split into four files. Each file has one job. Read it, and you can point at it and say what it does.

This is what real codebases look like.

---

## What it does

```bash
python ledger.py buyin alice 20
python ledger.py buyin bob   20
python ledger.py buyin alice 20      # alice re-buys for another $20
python ledger.py cashout alice 35
python ledger.py cashout bob   25
python ledger.py summary
python ledger.py log
```

Every command writes to a single file on disk: `ledger.db`. Open it with the `sqlite3` command if you want to see the raw rows.

---

## The four files

```
ledger.py    ← the file you run. Reads CLI args, calls into the others.
poker.py     ← what the math means: P/L, totals, book balance. Pure functions, no I/O.
storage.py   ← where the data lives. SQLite. The only file that knows about SQL.
display.py   ← how the data looks. Tabulate-based table printing.
```

The whole program is about 130 lines of code. Each file is under 60.

### How a command flows through the system

When you run `python ledger.py buyin alice 20`:

```
ledger.py        receives "buyin alice 20" from argparse
   ↓
storage.record() inserts one row into ledger.db
   ↓
ledger.py        prints a confirmation
```

When you run `python ledger.py summary`:

```
ledger.py             dispatches to cmd_summary
   ↓
storage.all_events()  reads every row from ledger.db
   ↓
display.summary_table(events)
   ↓                  for each unique player, calls
poker.total_buyin(), poker.total_cashout(), poker.pnl()
   ↓
tabulate              prints the formatted table
```

Each file calls only the file "below" it. `poker.py` doesn't know SQLite exists. `storage.py` doesn't know how anything gets printed. That's what people mean when they say "separation of concerns."

---

## Run it

```bash
pip install -r requirements.txt
python ledger.py buyin alice 20
python ledger.py summary
```

The first run creates `ledger.db` in the current directory. The file is git-ignored by the included `.gitignore` — data is not code, don't commit it.

---

## Why this is laid out this way

You could write the whole thing as one 130-line file. It would work. But:

- **Reading is faster.** When you want to change how the table looks, you open `display.py`. You don't have to scan a giant file looking for the print statements.
- **Changes don't ripple.** Switching from SQLite to a JSON file means rewriting `storage.py`. The other three files don't need to change — they don't know what storage is.
- **Testing is possible.** `poker.py` has no I/O, so you can call its functions with made-up event lists and check the answers. You can't easily test a function that opens a database and prints to the screen in the same call.

These three benefits — readable, contained, testable — get bigger as projects grow. This project is small enough to see them clearly.

---

## Going further

- **Add a `--date` flag** so you can record an event for a past night.
- **Add a `players` command** that just lists everyone who's ever played.
- **Swap SQLite for JSON** — rewrite `storage.py` to save events as `events.json` and reload them on every command. Nothing else should need to change. (If it does, you've leaked a concern.)
- **Add tests for `poker.py`.** Make a list of fake events, call `pnl()`, assert the answer. Try `pytest`.
- **Replace `tabulate` with `rich`.** Same domain, prettier output. Only `display.py` should change.

Each of these is an exercise in keeping the four files honest about their jobs.
