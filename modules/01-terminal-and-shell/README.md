# Module 01 — The Terminal & The Shell

> **You'll be able to:** Explain what a shell is and run basic commands with confidence.
> **Time:** ~30 min
> **Prereqs:** Module 00

## Why this matters

The terminal looks like a blank box waiting for you to know the secret words. That's not what it is. It's a loop. You type a command, the shell finds a program, runs it, and shows you the output. That's the whole thing. Once you see that loop clearly, the terminal stops being mysterious and starts being fast.

## Setup

```bash
cd ~/Developer/power-user-principles
```

---

## The Loop

Every command you type in a terminal follows this path:

```
You type something
      ↓
The shell parses it (splits command from arguments)
      ↓
The shell finds the program on disk
      ↓
The OS runs the program
      ↓
The program writes output
      ↓
You see the output
      ↓
The shell prints a new prompt
```

The shell itself is just a program. On Mac and most Linux systems, that program is `zsh` or `bash`. The shell's whole job is to read your input, find other programs, run them, and show you results.

**Try it:**
```bash
echo "the shell ran this"
```

`echo` is a program. It takes its arguments and prints them. Nothing more. The shell found it, ran it, showed you the output.

---

## Commands and Arguments

```bash
ls -la ~/Developer
```

Breaking this down:
- `ls` — the program (list directory contents)
- `-la` — flags (options that change behavior: `l` = long format, `a` = all including hidden)
- `~/Developer` — the argument (which directory to list)

**Try it:** Run `ls` with no arguments. Then run `ls -l`. Then run `ls -la`. See what changes.

---

## Where Programs Live

The shell finds programs by looking through a list of directories called `$PATH`.

```bash
echo $PATH
```

You'll see something like `/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin`. Colon-separated directories. When you type `ls`, the shell looks for a file called `ls` in each of those directories, in order, and runs the first one it finds.

```bash
which ls
which git
which python3
```

`which` tells you exactly which file the shell would run. This is how you debug "why is it running the wrong version of Python."

---

## The Prompt

Your prompt probably looks something like:

```
mattchisholm@MacBook-Pro power-user-principles %
```

It contains: your username, your machine name, the current directory, and the prompt character (`%` in zsh, `$` in bash). The current directory changes as you navigate.

**Check:** Run `pwd`. Confirm it matches the directory shown in your prompt.

---

## Standard Input, Output, and Error

Every program has three streams:

| Stream | Number | What it is |
|--------|--------|------------|
| stdin  | 0 | Input to the program (usually keyboard) |
| stdout | 1 | Normal output (what you see) |
| stderr | 2 | Error messages |

By default, stdout and stderr both print to your terminal. You can redirect them:

```bash
ls /doesnotexist 2>/dev/null   # discard error output
ls > output.txt                # send stdout to a file
```

Don't worry about mastering this now — you'll see it constantly and it'll click over time.

---

## Keyboard Shortcuts You'll Use Every Session

| Shortcut | What it does |
|----------|-------------|
| `Tab` | Complete the current command or path — use it constantly |
| `↑` / `↓` | Cycle through previous commands |
| `ctrl+c` | Stop the running program immediately |
| `ctrl+l` | Clear the screen (history stays) |
| `ctrl+r` | Search command history — type to filter |
| `ctrl+a` | Jump to start of line |
| `ctrl+e` | Jump to end of line |

`ctrl+c` is the most important key you'll learn today. When something is running and shouldn't be, that's how you stop it.

**Try it:** Run `cat` with no arguments. Nothing happens — it's waiting for input. Press `ctrl+c` to kill it.

---

## Getting Help

```bash
man ls        # manual page for ls (press q to quit)
ls --help     # most commands support --help
```

Man pages are dense. Don't try to read them top to bottom. Search for what you need with `/` while in the pager.

---

## Follow-Along Demo

There's a script in `demo/` that runs a sequence of commands and shows you exactly what the shell is doing at each step:

```bash
bash modules/01-terminal-and-shell/demo/shell-loop.sh
```

Open it in an editor after running it. Every line is something you could type manually — the script is just those commands in a file.

---

## Verify

```bash
bash modules/01-terminal-and-shell/verify.sh
```

---

## What you can do now

You understand what the shell is (a program that runs other programs), how commands are structured (program + flags + arguments), and how to find help. The terminal is no longer a black box.

## Stretch

- Run `type ls`. What does it tell you about `ls`?
- Run `history | tail -20`. What were your last 20 commands?
- Run `man man`. What does the manual for the manual say?
