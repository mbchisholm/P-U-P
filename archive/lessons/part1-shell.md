# The File System and Shell

Finder is a graphical skin over the file system. The terminal is direct access to the same thing. Everything you can do by clicking, you can do faster by typing — and some things you can only do by typing.

---

## The Mental Model

Your file system is a tree. You are always somewhere in it.

```
/                          ← root (the whole disk)
├── Users/
│   └── you/               ← your home directory (~)
│       ├── Desktop/
│       ├── Downloads/
│       └── Developer/     ← where your code should live
├── Applications/
└── etc/
```

`~` is always shorthand for your home directory. `~` and `/Users/yourname` are the same thing.

---

## Navigation

```bash
pwd               # where am I?
ls                # what's here?
ls -la            # show hidden files, sizes, permissions
cd Developer      # go into Developer/
cd ..             # go up one level
cd ~              # go home
cd -              # go back to where you just were
```

**Tab completion is not optional.** Type the first two letters of anything and press Tab. If there's one match, it completes. If there are multiple, press Tab again to see them. Use it for every path. It catches typos and saves time.

---

## Files

```bash
touch notes.txt           # create an empty file
echo "hello" > notes.txt  # write text to a file (overwrites)
echo "world" >> notes.txt # append to a file
cat notes.txt             # print file contents
```

---

## Directories

```bash
mkdir projects             # make a directory
mkdir -p a/b/c             # make nested directories at once
rm notes.txt               # delete a file
rm -r projects/            # delete a directory and everything in it
```

`rm` is permanent. There is no trash. Think before you run it.

---

## Moving and Copying

```bash
mv notes.txt archive/notes.txt    # move (also used to rename)
mv notes.txt renamed.txt          # rename
cp notes.txt notes-backup.txt     # copy
cp -r folder/ folder-backup/      # copy a directory
```

`mv` is how you rename. There's no separate rename command.

---

## Pipes: Connecting Commands

The output of one command can become the input of the next.

```bash
ls -la | grep ".txt"      # list files, then filter for .txt lines
history | tail -20        # recent commands, last 20 lines
cat notes.txt | wc -l     # count lines in a file
```

`|` passes output. `grep "pattern"` filters for lines containing the pattern. `tail -20` takes the last 20 lines. These are small tools that do one thing — chaining them is how you build complex operations without writing a script.

---

## Finding Things

```bash
find . -name "*.py"          # find all Python files from here down
grep -r "TODO" .             # search file contents recursively
grep -r "TODO" . --include="*.py"   # narrow to Python files only
```

---

## Useful Shortcuts

| Shortcut | What it does |
|---|---|
| Tab | Complete the current path or command |
| ↑ / ↓ | Cycle through command history |
| ctrl+c | Kill the running process |
| ctrl+l | Clear the screen |
| ctrl+r | Search command history |
| cmd+t | New terminal tab (Mac) |

`ctrl+c` is the most important. When something is running and you need it to stop, that's the key.

---

## Hands-On

1. Open Terminal. Run `pwd`. Run `ls`. Run `ls -la`.
2. Navigate to your home directory. Create a `Developer/` folder. Create a `practice/` folder inside it.
3. Create a file called `hello.txt` with the text "hello world" using `echo`.
4. Rename it to `greeting.txt` using `mv`.
5. Run: `ls -la | grep greeting`
6. Delete the file. Verify it's gone.

---

## The Three Rules

1. **Tab complete everything.** Typing full paths by hand is how you introduce typos and misunderstandings.
2. **`ls -la` before you do anything destructive.** Know what's in a directory before you `rm` from it.
3. **`ctrl+c` stops things.** If something is running and shouldn't be, that's how you kill it.
