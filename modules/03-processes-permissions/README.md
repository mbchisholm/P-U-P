# Module 03 — Processes, Permissions, Networks

> **You'll be able to:** See what's running on your machine, understand file ownership, and find your IP address.
> **Time:** ~45 min
> **Prereqs:** Module 02

## Why this matters

Programs are not magic — they're processes: numbered, pauseable, killable. Files are not just bytes — they have owners and permission rules. Your machine is not an island — it has an address on every network it's connected to. These three ideas unlock a huge amount of what "understanding your computer" actually means.

## Setup

```bash
cd ~/Developer/power-user-principles
```

---

## Processes

When you run a program, the OS creates a **process** — a running instance of that program, with a unique ID (PID).

```bash
ps              # your current shell's processes
ps aux          # every process on the system (a=all, u=user format, x=no tty)
```

The output includes: the user who owns it, the PID, CPU%, memory%, and the command that launched it.

**Try it:** Run `ps aux | grep Terminal` (Mac) or `ps aux | grep bash` (WSL).

### top / htop

```bash
top             # live process viewer (press q to quit)
```

`top` updates in real time. You can see CPU and memory usage per process. Press `q` to quit.

### kill

Every process has a PID. You can terminate any process you own:

```bash
kill 12345      # ask process 12345 to terminate (SIGTERM)
kill -9 12345   # force-kill (SIGKILL, no cleanup)
```

`ctrl+c` in the terminal sends SIGTERM to the currently running foreground process. It's the same signal.

**Try it:** Open a second terminal tab. Run `sleep 100` in it. Run `ps aux | grep sleep` in your first tab. Note the PID. Run `kill <PID>`. Watch the second tab exit.

---

## Permissions

Every file has three permission sets: one for the **owner**, one for the **group**, and one for **everyone else**. Each set can grant **r**ead, **w**rite, and e**x**ecute.

```bash
ls -la
```

```
-rw-r--r--  1  matt  staff  204  May 21 10:00  README.md
drwxr-xr-x  3  matt  staff   96  May 21 10:00  modules/
```

Reading the permission string (`-rw-r--r--`):
- Position 1: `-` = file, `d` = directory
- Positions 2–4: owner (`rw-` = read + write, no execute)
- Positions 5–7: group (`r--` = read only)
- Positions 8–10: others (`r--` = read only)

### chmod

```bash
chmod +x script.sh          # make executable for everyone
chmod 644 file.txt          # owner rw, group r, others r
chmod 755 dir/              # owner rwx, group rx, others rx (common for dirs)
```

**Try it:** Check whether `modules/00-start-here/verify.sh` is executable:
```bash
ls -la modules/00-start-here/verify.sh
```

If it's not executable (`-rw-...`), run `chmod +x modules/00-start-here/verify.sh`.

### sudo

`sudo` runs a command as the superuser (root). Root owns the whole system.

```bash
sudo somecommand     # asks for your password, then runs as root
```

Use `sudo` only when a command tells you you need it (permission denied). Don't run everything as sudo — it bypasses the safety rails.

---

## Networks

### Your IP address

Every device on a network has an IP address — a number that identifies it.

```bash
# macOS
ipconfig getifaddr en0    # your WiFi IP
ipconfig getifaddr en1    # your ethernet IP (if connected)

# Linux / WSL
ip addr show              # all network interfaces and their IPs
```

**Try it:** Find your IP address. Write it down — you'll use it in Module 11.

### ping

`ping` sends a small packet to an address and times how long it takes to come back.

```bash
ping google.com           # ping forever (ctrl+c to stop)
ping -c 3 google.com      # send 3 packets and stop
```

If `ping` fails, you probably don't have internet. If `ping 8.8.8.8` works but `ping google.com` doesn't, DNS is broken.

### Ports

An IP address gets you to a device. A **port** gets you to a specific service on that device.

```
192.168.1.50:22     ← SSH
192.168.1.50:80     ← HTTP
192.168.1.50:443    ← HTTPS
192.168.1.50:5000   ← your Flask app (when you run it)
```

When you run a web server and it says "Serving on port 5000," it means: any device that can reach your IP can talk to port 5000 and get a response.

---

## Disk Usage

```bash
df -h              # disk space for all mounted volumes (h = human-readable sizes)
du -sh ~/Developer  # size of your Developer folder
```

---

## Verify

```bash
bash modules/03-processes-permissions/verify.sh
```

---

## What you can do now

You can see every process running on your machine, kill any of them, read and change file permissions, find your IP address, and ping a host. Your machine is no longer a black box.

## Stretch

- Run `lsof -i :5000` — lists open files listening on port 5000. Nothing there yet. Run it again after Module 09 when you have a server running.
- Run `top`, press `M` (Mac) to sort by memory. What's using the most?
- Run `chmod 000 /tmp/test-perm && cat /tmp/test-perm` — what error do you get? Run `chmod 644 /tmp/test-perm` to restore it.
