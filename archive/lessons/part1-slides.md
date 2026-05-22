---
marp: true
theme: default
paginate: true
style: |
  section {
    font-family: 'SF Mono', 'Fira Code', monospace;
    background: #0d1117;
    color: #e6edf3;
  }
  h1 { color: #58a6ff; }
  h2 { color: #79c0ff; }
  code { background: #161b22; color: #e6edf3; }
  pre { background: #161b22; border: 1px solid #30363d; }
  strong { color: #ffa657; }
  blockquote {
    border-left: 4px solid #f85149;
    background: #2d1115;
    color: #ffa198;
    padding: 0.5em 1em;
  }
  .center {
    text-align: center;
  }
  .big {
    font-size: 1.8em;
    line-height: 1.4;
  }
---

# The File System & Shell

## Part 1 — Power User Principles

---

# Finder is a skin.

The file system underneath it is the same one the terminal talks to directly.

---

# Your file system is a tree.

```
/
├── Users/
│   └── you/          ← ~ (home)
│       ├── Desktop/
│       ├── Downloads/
│       └── Developer/
├── Applications/
└── etc/
```

`~` is always shorthand for your home directory.

---

# Where are you? What's here? How do you move?

```bash
pwd        # where am I?
ls -la     # what's here?
cd ..      # go up
cd ~       # go home
cd -       # go back
```

**Tab completion is not optional.**

---

# Tab completes. Always.

Type two letters. Press Tab.

One match: it completes. Multiple: press Tab again.

---

# Creating, reading, writing files.

```bash
touch notes.txt           # create
echo "hello" > notes.txt  # write (overwrites)
echo "world" >> notes.txt # append
cat notes.txt             # print
```

**`>`** overwrites. **`>>`** appends.

---

# Directories. And the one command you treat carefully.

```bash
mkdir projects
mkdir -p a/b/c
rm notes.txt       # delete file
rm -r projects/    # delete folder and everything in it
```

> `rm` is permanent. There is no trash.

---

# `mv` does two jobs.

```bash
mv notes.txt archive/notes.txt   # move
```

```bash
mv notes.txt renamed.txt         # rename
```

There is no separate rename command.

---

# The output of one command becomes the input of the next.

```bash
ls -la | grep ".txt"
history | tail -20
cat notes.txt | wc -l
```

**`|`** is the pipe. Small tools. One job each. Chain them.

---

# Search the file system. Search file contents.

```bash
find . -name "*.py"
grep -r "TODO" .
grep -r "TODO" . --include="*.py"
```

**`find`** = file names. **`grep`** = file contents.

---

# The shortcuts that matter.

| Shortcut    | What it does                          |
| ----------- | ------------------------------------- |
| `Tab`       | Complete the current word             |
| `↑` / `↓`   | Walk through command history          |
| **`ctrl+c`** | **Stop the running command**          |
| `ctrl+l`    | Clear the screen                      |
| `ctrl+r`    | Search command history                |
| `cmd+t`     | New terminal tab                      |

---

# Three rules. Commit them.

1. Tab complete everything.
2. `ls -la` before anything destructive.
3. `ctrl+c` stops things.

---

<div class="center big">

▎ "Everything Finder does, you just did faster."

</div>

Next: what do real projects actually look like?
