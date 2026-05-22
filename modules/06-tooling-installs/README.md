# Module 06 — Tooling: Python, Node, Git

> **You'll be able to:** Install and manage Python and Node.js using version managers, and configure git globally.
> **Time:** ~45 min
> **Prereqs:** Module 00

## Why this matters

You could install Python by downloading an installer from python.org. You'd end up with exactly one version, locked in place, and you'd fight it the first time a project requires a different version. Version managers solve this: install `pyenv`, and you can have Python 3.11 and 3.12 side by side, switching between them per-project. Same idea for Node with `nvm`. This is how real projects are managed.

## Setup

```bash
cd ~/Developer/power-user-principles
```

---

## Package Managers

Before installing Python or Node, you need a way to install things.

### macOS — Homebrew

If you completed Module 00 (Mac path), Homebrew is already installed.

```bash
brew --version   # should print Homebrew 4.x.x or higher
```

### Windows (WSL) — apt

WSL uses `apt`, Ubuntu's package manager.

```bash
sudo apt update    # refresh the package list
sudo apt upgrade   # apply any pending updates
```

---

## Python with pyenv

`pyenv` lets you install and switch between Python versions.

### macOS

```bash
brew install pyenv
```

After install, add pyenv to your shell. Add these lines to `~/.zshrc`:

```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

Then reload:
```bash
source ~/.zshrc
```

### Windows (WSL)

```bash
curl https://pyenv.run | bash
```

Add these to `~/.bashrc`:
```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

Then reload:
```bash
source ~/.bashrc
```

---

### Install Python 3.12

```bash
pyenv install 3.12.3
pyenv global 3.12.3
```

The install takes 2–5 minutes. While it's running, that's a good time to read the next section.

> **What's happening:** pyenv downloads the Python 3.12.3 source code and compiles it. That's why it takes a few minutes. The compiled binary lives in `~/.pyenv/versions/3.12.3/`.

**Check:**
```bash
python --version      # should print Python 3.12.3
which python          # should be in ~/.pyenv/shims/
```

### pip — Python's package installer

pip comes with Python. Verify:

```bash
pip --version
```

You'll use pip to install libraries: `pip install requests`, `pip install flask`, etc.

---

## Node.js with nvm

`nvm` (Node Version Manager) does for Node what pyenv does for Python.

### macOS and WSL

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

The install script adds nvm to your shell config automatically. Open a new terminal tab (or `source ~/.zshrc` / `source ~/.bashrc`) and verify:

```bash
nvm --version
```

### Install Node LTS

```bash
nvm install --lts
nvm use --lts
nvm alias default node
```

**Check:**
```bash
node --version    # should print v20.x.x or v22.x.x
npm --version     # should print 10.x.x or higher
```

---

## Git — Global Configuration

You already installed git and set your name and email in Module 00 or 04. Verify:

```bash
git config --global user.name
git config --global user.email
```

A few more useful settings:

```bash
git config --global init.defaultBranch main    # use 'main' instead of 'master' for new repos
git config --global pull.rebase false           # merge on pull (vs. rebase)
git config --global core.editor "code --wait"  # use VS Code as git's editor
```

The last one makes VS Code open for commit messages and merge conflicts when git needs your input.

---

## Verify

```bash
bash modules/06-tooling-installs/verify.sh
```

---

## What you can do now

You have Python 3.12, Node.js LTS, and git, all properly configured. You can start any project that uses any of these without fighting version conflicts.

## Stretch

- Install Python 3.11 alongside 3.12: `pyenv install 3.11.9`. Switch to it: `pyenv global 3.11.9`. Switch back: `pyenv global 3.12.3`. Check with `python --version` each time.
- Create a virtual environment: `python -m venv .venv && source .venv/bin/activate`. Notice your prompt changes. Run `which python`. Deactivate with `deactivate`.
- Run `nvm list` — see all installed Node versions. Install another: `nvm install 18`.
