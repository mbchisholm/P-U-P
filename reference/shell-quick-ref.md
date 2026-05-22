# Shell Quick Reference

## Navigation
| Command | What it does |
|---|---|
| `pwd` | Print current directory |
| `ls` | List files |
| `ls -la` | List all files with details |
| `cd <dir>` | Change directory |
| `cd ..` | Go up one level |
| `cd ~` | Go home |
| `cd -` | Go back to previous directory |

## Files & Directories
| Command | What it does |
|---|---|
| `touch <file>` | Create empty file |
| `mkdir <dir>` | Create directory |
| `mkdir -p a/b/c` | Create nested directories |
| `mv <src> <dst>` | Move or rename |
| `cp <src> <dst>` | Copy file |
| `cp -r <src> <dst>` | Copy directory |
| `rm <file>` | Delete file (permanent) |
| `rm -r <dir>` | Delete directory (permanent) |
| `cat <file>` | Print file contents |

## Finding Things
| Command | What it does |
|---|---|
| `find . -name "*.py"` | Find files by name |
| `grep "pattern" <file>` | Search in file |
| `grep -r "pattern" .` | Search recursively |
| `grep -n "pattern"` | Show line numbers |
| `which <cmd>` | Where is this program? |

## Pipes & Redirection
| Command | What it does |
|---|---|
| `cmd1 \| cmd2` | Pipe output of cmd1 to cmd2 |
| `cmd > file` | Redirect output to file (overwrite) |
| `cmd >> file` | Append output to file |
| `cmd 2>/dev/null` | Discard error output |

## Processes
| Command | What it does |
|---|---|
| `ps aux` | List all processes |
| `top` | Live process viewer |
| `kill <pid>` | Terminate process |
| `kill -9 <pid>` | Force-kill process |

## Networking
| Command | What it does |
|---|---|
| `ipconfig getifaddr en0` | Your WiFi IP (Mac) |
| `ip addr show` | Network interfaces (Linux) |
| `ping <host>` | Test connectivity |
| `ssh user@host` | SSH into a remote machine |

## Keyboard Shortcuts
| Shortcut | What it does |
|---|---|
| `Tab` | Complete command or path |
| `↑ / ↓` | Navigate history |
| `ctrl+c` | Kill running process |
| `ctrl+l` | Clear screen |
| `ctrl+r` | Search history |
| `ctrl+a` | Start of line |
| `ctrl+e` | End of line |
| `ctrl+k` | Delete to end of line |
| `ctrl+w` | Delete previous word |
