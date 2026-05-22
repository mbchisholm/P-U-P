# Module 07 — Terminal & Editor Config

> **You'll be able to:** Customize your terminal and shell so they match how you think.
> **Time:** ~30 min
> **Prereqs:** Module 01

## Why this matters

You'll spend thousands of hours in a terminal. The default configuration is designed for everyone, which means it's optimized for no one. Ten minutes of setup here pays back every session for years. You'll also install two tools that make reading files in the terminal dramatically better.

## Setup

```bash
cd ~/Developer/power-user-principles
```

---

## Your Shell Config File

Every time a new shell session starts, it reads a configuration file. For zsh (Mac default): `~/.zshrc`. For bash (WSL default): `~/.bashrc`.

```bash
# macOS
cat ~/.zshrc

# WSL
cat ~/.bashrc
```

This file runs shell code. Anything you put here applies to every new terminal session.

> Changes to `~/.zshrc` or `~/.bashrc` don't apply to the current session automatically. Either open a new terminal window or run `source ~/.zshrc` (or `~/.bashrc`) to reload.

---

## Aliases

Aliases let you define short names for commands you run constantly.

Add these to your shell config:

```bash
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias dev="cd ~/Developer"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias glog="git log --oneline --graph --decorate"
```

**How to add them:**

```bash
# macOS
echo 'alias ll="ls -la"' >> ~/.zshrc
source ~/.zshrc

# WSL
echo 'alias ll="ls -la"' >> ~/.bashrc
source ~/.bashrc
```

Or open the file in your editor and add the lines directly:

```bash
code ~/.zshrc      # macOS
code ~/.bashrc     # WSL
```

**Try it:** After reloading, type `ll` — it should run `ls -la`.

---

## Prompt Customization

Your prompt tells you where you are. Make it useful.

The default may already be reasonable. But if you want to see your git branch in the prompt, here's a minimal addition to your shell config:

### macOS (zsh)

```bash
# Show git branch in prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%n@%m %~${vcs_info_msg_0_} %% '
```

### WSL (bash)

```bash
# Show git branch in prompt
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}
PS1='\u@\h:\w$([ -n "$(parse_git_branch)" ] && echo " ($(parse_git_branch))") \$ '
```

After reloading your shell and navigating to a git repo, the prompt will show the current branch. You'll never accidentally commit to `main` when you meant a feature branch.

---

## Better File Viewing

Two tools that make the terminal dramatically more readable:

### bat — syntax-highlighted cat

`bat` is a replacement for `cat` that adds syntax highlighting and line numbers.

#### macOS
```bash
brew install bat
```

#### Windows (WSL)
```bash
sudo apt install bat
```

> On some Ubuntu versions, the command is `batcat`, not `bat`. Run `which batcat` — if it exists, add `alias bat="batcat"` to your shell config.

**Try it:**
```bash
bat modules/01-terminal-and-shell/README.md
```

### glow — markdown in the terminal

`glow` renders Markdown beautifully in the terminal. Useful for reading module READMEs.

#### macOS
```bash
brew install glow
```

#### Windows (WSL)
```bash
sudo apt install glow
```

**Try it:**
```bash
glow modules/02-filesystem/README.md
```

---

## Terminal Keyboard Shortcuts

These work in Mac's Terminal.app and most terminal emulators:

| Shortcut | What it does |
|---|---|
| `cmd+t` (Mac) | New tab |
| `cmd+w` (Mac) | Close tab |
| `cmd+option+←/→` (Mac) | Switch tabs |
| `ctrl+a` | Jump to start of line |
| `ctrl+e` | Jump to end of line |
| `ctrl+k` | Delete from cursor to end of line |
| `ctrl+u` | Delete from cursor to start of line |
| `ctrl+w` | Delete the previous word |
| `option+←/→` (Mac) | Move word by word |

---

## VS Code Settings (Preview for Module 08)

While you're configuring things: if VS Code is installed, open it and set the terminal integration font:

1. `cmd+,` (Mac) / `ctrl+,` (WSL via VS Code remote) to open Settings
2. Search for `terminal font`
3. Set **Terminal > Integrated: Font Family** to `Menlo, Monaco, 'Courier New', monospace`

---

## Verify

```bash
bash modules/07-terminal-config/verify.sh
```

---

## What you can do now

Your terminal works the way your brain works. Aliases save keystrokes. `bat` and `glow` make reading files pleasant. The prompt tells you what branch you're on. Small investments, compounding returns.

## Stretch

- Add an alias for a command you find yourself typing repeatedly.
- Try [Starship](https://starship.rs) for a cross-shell prompt: `brew install starship` (Mac), then follow their docs. It's popular and beautiful.
- Set up zsh-autosuggestions (Mac): `brew install zsh-autosuggestions`, then add `source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh` to `~/.zshrc`. It shows ghost text of your previous commands as you type.
