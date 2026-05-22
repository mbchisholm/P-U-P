# Module 02 — The File System Is a Tree

> **You'll be able to:** Navigate, create, move, and delete files from the terminal. Search for anything.
> **Time:** ~45 min
> **Prereqs:** Module 01

## Why this matters

Finder is a graphical skin over the file system. The terminal is direct access to the same thing. Everything you can do by clicking, you can do faster by typing — and some things you can only do by typing. More importantly: understanding the file system as a tree changes how you think about where things are and why paths look the way they do.

## Setup

```bash
cd ~/Developer/power-user-principles
mkdir -p modules/02-filesystem/examples
cd modules/02-filesystem/examples
```

You'll create practice files here during the module. The `examples/` directory is git-ignored, so none of this pollutes the repo.

---

## The Tree

Your file system is a tree. There is one root: `/`. Everything branches from there.

```
/                          ← root (the whole disk)
├── Users/
│   └── you/               ← your home directory (~)
│       ├── Desktop/
│       ├── Downloads/
│       └── Developer/     ← where your code lives
├── Applications/
├── usr/
│   └── bin/               ← where most programs live
└── etc/                   ← system configuration
```

`~` is always shorthand for your home directory. `/Users/yourname` and `~` are the same path.

**Try it:** Run `ls /`. You're looking at the top of the tree.

---

## Navigation

```bash
pwd               # where am I? (Print Working Directory)
ls                # what's here?
ls -la            # all files, long format, including hidden files
cd Developer      # go into Developer/
cd ..             # go up one level
cd ~              # go home
cd -              # go back to where you just were
```

**Tab completion is not optional.** Type the first two letters of anything and press Tab. If there's one match, it completes. If there are multiple, press Tab again to see options. Use it for every path. It catches typos before they become mistakes.

**Try it:** Type `cd ~/Dev` and press Tab. It should complete to `~/Developer/`.

---

## Absolute vs. Relative Paths

```bash
# Absolute — starts with / or ~, works from anywhere
cd /Users/you/Developer
cd ~/Developer

# Relative — starts from where you are right now
cd Developer        # only works if Developer exists here
cd ../Documents     # go up one level then into Documents
```

**Check:** Run `pwd` after each `cd` to see where you ended up.

---

## Creating Files and Directories

```bash
touch notes.txt              # create an empty file
echo "hello" > notes.txt    # write text to a file (overwrites)
echo "world" >> notes.txt   # append to a file
cat notes.txt               # print file contents
mkdir projects               # make a directory
mkdir -p a/b/c               # make nested directories at once
```

**Try it:**
```bash
cd ~/Developer/power-user-principles/modules/02-filesystem/examples
touch hello.txt
echo "this is my file" > hello.txt
cat hello.txt
```

---

## Moving and Copying

```bash
mv notes.txt archive/notes.txt    # move
mv notes.txt renamed.txt          # rename (mv is also how you rename)
cp notes.txt notes-backup.txt     # copy a file
cp -r folder/ folder-backup/      # copy a directory and its contents
```

There is no separate rename command. `mv` does it.

**Try it:**
```bash
mv hello.txt greeting.txt
ls
```

---

## Deleting

```bash
rm greeting.txt         # delete a file
rm -r projects/         # delete a directory and everything in it
```

> `rm` is permanent. There is no trash. There is no undo. Know what's in a directory before you delete it: run `ls` first.

**Try it:**
```bash
ls -la
rm greeting.txt
ls
```

---

## Pipes: Connecting Commands

The output of one command becomes the input of the next. `|` is the pipe character.

```bash
ls -la | grep ".txt"        # list files, filter for lines containing .txt
history | tail -20          # show the last 20 commands from history
cat notes.txt | wc -l       # count lines in a file
```

`grep "pattern"` filters for lines containing the pattern. `tail -20` takes the last 20 lines. `wc -l` counts lines. These are small programs that do one thing each. Chaining them is how you build complex operations without writing a script.

**Try it:**
```bash
ls -la | grep "verify"
```

**Follow-along demo:** There's a runnable script in `demo/` that fetches live weather data and pipes it through several commands to build a growing log file — a concrete version of everything above.

```bash
bash modules/02-filesystem/demo/pipeline.sh
```

Run it twice. See `>>` append vs. `>` overwrite in action.

---

## Finding Things

```bash
find . -name "*.sh"                         # find all shell scripts from here down
grep -r "TODO" .                            # search file contents recursively
grep -r "TODO" . --include="*.py"          # narrow to Python files only
grep -n "verify" modules/00-start-here/README.md   # show line numbers
```

`find` searches by name. `grep` searches by content. Between them, nothing stays hidden.

**Try it:**
```bash
find . -name "verify.sh"
```

---

## Hidden Files

Files starting with `.` are hidden from `ls` by default:

```bash
ls          # doesn't show hidden files
ls -la      # shows everything, including .hidden files
ls -a       # shows hidden files, no long format
```

`.gitignore`, `.env`, `.zshrc` — all hidden files you'll use constantly.

---

## Useful Shortcuts (summary)

| Shortcut | What it does |
|---|---|
| `Tab` | Complete the current path or command |
| `↑` / `↓` | Cycle through command history |
| `ctrl+c` | Kill the running process |
| `ctrl+l` | Clear the screen |
| `ctrl+r` | Search command history |

---

## Verify

```bash
bash modules/02-filesystem/verify.sh
```

---

## What you can do now

You can navigate the file system, create files and directories, rename and delete, search for files by name and content, and chain commands with pipes. Finder is optional.

## Stretch

- Run `ls -laSh ~/Desktop`. What does the `S` flag do? What does `h` do? (Hint: `man ls`)
- Find all Markdown files in this repo: `find . -name "*.md"`
- Count how many lines are in every `.sh` file: `find . -name "*.sh" -exec wc -l {} +`
