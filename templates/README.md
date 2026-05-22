# Templates

Starter files you can copy into your own projects. Each subdirectory is self-contained — copy what you need.

## What's here

### [`env-example/`](env-example/.env.example)

A `.env.example` template showing the pattern for keeping secrets out of code. Copy it to a new project, rename to `.env`, fill in your values, and add `.env` to `.gitignore`.

Used in [Module 09: Hitting an API](../modules/09-api-project/README.md).

### [`gitignore-starter/`](gitignore-starter/.gitignore)

A `.gitignore` with sensible defaults for a Python + Node project (virtual envs, `__pycache__`, `.env`, database files, OS junk). Drop it into any new repo to start clean.

### [`poker-ledger-starter/`](poker-ledger-starter/README.md)

The Module 10 poker ledger refactored into four files — one CLI entry point, one module for math, one for storage, one for formatting. Same domain you built in the module, split into pieces the way real codebases are organized. See its [README](poker-ledger-starter/README.md) for the file-by-file map.
