# Module 04 — SSH Keys & GitHub

> **You'll be able to:** Generate an SSH key, add it to GitHub, and authenticate without a password.
> **Time:** ~45 min
> **Prereqs:** Module 02

## Why this matters

An SSH key is a cryptographic identity. When you generate one, you create a matched pair: a private key that never leaves your machine, and a public key you can share freely. GitHub keeps your public key. When you connect, GitHub challenges you with something only your private key can answer. You never type a password. You can't accidentally leak a password because there isn't one.

This is the same authentication model used for every production server in the world.

## Setup

```bash
cd ~/Developer/power-user-principles
```

---

## How SSH Keys Work

```
Your machine                    GitHub
─────────────────               ─────────────────
~/.ssh/id_ed25519     ←paired→  your public key
(private key)                    (stored in settings)

When you connect:
  1. GitHub: "prove you're you"
  2. Your machine signs a challenge with the private key
  3. GitHub verifies the signature with your public key
  4. Match → access granted
```

The private key never leaves `~/.ssh/`. The public key is safe to share — it's mathematically impossible to derive the private key from it.

---

## Create a GitHub Account

If you don't have one yet:
1. Go to [github.com](https://github.com) and click **Sign up**
2. Choose a username — it's public and shows on your work
3. Verify your email address

---

## Generate an SSH Key

```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

- `-t ed25519` — the key algorithm (modern, fast, secure)
- `-C "..."` — a comment that labels the key (use your email)

It asks where to save the key (`~/.ssh/id_ed25519` — press Enter to accept the default) and for a passphrase (press Enter twice for no passphrase, or set one for extra security).

**Check:**
```bash
ls ~/.ssh/
```

You should see:
```
id_ed25519       ← your private key (never share this)
id_ed25519.pub   ← your public key (safe to share)
```

---

## Copy Your Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire output — it starts with `ssh-ed25519` and ends with your email. It's one long line.

### macOS

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

(Copies to clipboard automatically.)

### Windows (WSL)

```bash
cat ~/.ssh/id_ed25519.pub | clip.exe
```

---

## Add the Key to GitHub

1. Go to [github.com/settings/keys](https://github.com/settings/keys)
2. Click **New SSH key**
3. Title: something descriptive ("MacBook 2024" or "WSL Ubuntu")
4. Key type: **Authentication Key**
5. Paste your public key into the Key field
6. Click **Add SSH key**

---

## Verify the Connection

```bash
ssh -T git@github.com
```

You'll see a warning about the host fingerprint the first time. Type `yes` and press Enter.

Expected output:
```
Hi yourusername! You've successfully authenticated, but GitHub does not provide shell access.
```

That message is success. The "no shell access" part is expected — GitHub doesn't let you SSH in as a user, only for git operations.

---

## Using SSH for git Clone

From now on, clone repos using the SSH URL (not HTTPS):

```bash
# SSH (use this) — authenticates with your key
git clone git@github.com:username/repo.git

# HTTPS (avoid) — asks for username/password or token
git clone https://github.com/username/repo.git
```

**Try it:** Create a new repo on GitHub (click the `+` in the top right → New repository). Name it `test-ssh`. Clone it with the SSH URL. Make a file, commit it, push it. Verify it appears on GitHub.

---

## Verify

```bash
bash modules/04-ssh-and-github/verify.sh
```

---

## What you can do now

You have an SSH key, it's registered on GitHub, and you can clone, push, and pull without ever typing a password. You can SSH into any server that has your public key.

## Stretch

- Run `ssh-add -l` — lists keys currently loaded in the SSH agent. Is yours there?
- Read your public key: `cat ~/.ssh/id_ed25519.pub`. What information can you extract from it?
- Create a second key for a different use: `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github2 -C "second key"`. Notice the `-f` flag that specifies the filename.
