# Shell Quick Reference

The shell commands you'll reach for every session. See [git-quick-ref.md](git-quick-ref.md) for git-specific commands and [shortcuts.md](shortcuts.md) for editor and terminal keybindings.

## Navigation

| Command | What it does |
|---|---|
| `pwd` | Print the current directory |
| `ls` | List files |
| `ls -la` | List everything, with details and hidden files |
| `cd <dir>` | Change directory |
| `cd ..` | Go up one level |
| `cd ~` | Go to your home directory |
| `cd -` | Go back to the previous directory |

## Files & directories

| Command | What it does |
|---|---|
| `touch <file>` | Create an empty file |
| `mkdir <dir>` | Create a directory |
| `mkdir -p a/b/c` | Create nested directories in one step |
| `mv <src> <dst>` | Move or rename |
| `cp <src> <dst>` | Copy a file |
| `cp -r <src> <dst>` | Copy a directory and its contents |
| `rm <file>` | Delete a file (**permanent**, no trash) |
| `rm -r <dir>` | Delete a directory and everything in it (**permanent**) |
| `cat <file>` | Print file contents to the terminal |

## Finding things

| Command | What it does |
|---|---|
| `find . -name "*.py"` | Find files by name pattern |
| `grep "pattern" <file>` | Search inside one file |
| `grep -r "pattern" .` | Search inside every file from here down |
| `grep -n "pattern" <file>` | Include line numbers in matches |
| `which <cmd>` | Show which file would run when you type `<cmd>` |

## Pipes & redirection

| Command | What it does |
|---|---|
| `cmd1 \| cmd2` | Pipe `cmd1`'s output into `cmd2` |
| `cmd > file` | Redirect output to a file (**overwrites**) |
| `cmd >> file` | Append output to a file |
| `cmd 2>/dev/null` | Discard error output |

## Processes

| Command | What it does |
|---|---|
| `ps aux` | List every process on the system |
| `top` | Live process viewer (press `q` to quit) |
| `kill <pid>` | Politely ask a process to stop |
| `kill -9 <pid>` | Force-kill a process (no cleanup) |

## Networking

| Command | What it does |
|---|---|
| `ipconfig getifaddr en0` | Your WiFi IP (macOS) |
| `ip addr show` | All network interfaces (Linux / WSL) |
| `ping <host>` | Test whether you can reach a host |
| `ssh <user>@<host>` | SSH into a remote machine |

## Essential keyboard shortcuts

For the full list see [shortcuts.md](shortcuts.md).

| Shortcut | What it does |
|---|---|
| `Tab` | Complete the current command or path |
| `↑` / `↓` | Cycle through command history |
| `ctrl+c` | Stop the running program |
| `ctrl+l` | Clear the screen |
| `ctrl+r` | Search command history |
| `ctrl+a` / `ctrl+e` | Jump to start / end of line |
