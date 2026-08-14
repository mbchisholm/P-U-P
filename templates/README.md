# Templates

Starter files you can copy into your own projects. Each subdirectory is self-contained — copy what you need.

## What's here

### [`env-example/`](env-example/.env.example)

A `.env.example` template showing the pattern for keeping secrets out of code. Copy it to a new project, rename to `.env`, fill in your values, and add `.env` to `.gitignore`.

Used in [Module 09: Hitting an API](../modules/09-api-project/README.md).

### [`gitignore-starter/`](gitignore-starter/.gitignore)

A `.gitignore` with sensible defaults for a Python + Node project (virtual envs, `__pycache__`, `.env`, database files, OS junk). Drop it into any new repo to start clean.

### [`ui-starters/`](ui-starters/README.md)

Four clean, dependency-free HTML pages — landing, dashboard, form, article — that share one design-token block, so you can re-theme all of them by editing a few CSS variables. Copy one instead of starting from a blank file. See its [README](ui-starters/README.md) for the token system and the rules the pages bake in.

Used in [Module 12: Frontend Design](../modules/12-frontend-design/README.md).

### [`poker-ledger-starter/`](poker-ledger-starter/README.md)

The Module 10 poker ledger refactored into four files — one CLI entry point, one module for math, one for storage, one for formatting. Same domain you built in the module, split into pieces the way real codebases are organized. See its [README](poker-ledger-starter/README.md) for the file-by-file map.
