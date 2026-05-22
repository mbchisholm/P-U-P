# SSH Keys & File Ownership

A key is not a machine credential — it's a **user** credential. The file lives in that user's home directory, and SSH will refuse to use it if anything is wrong with ownership or permissions.

---

## Why This Matters

This is the error we hit:

```
Permission denied (publickey)
```

The key existed. GitHub had the public half. But we were running commands as `mbc`, and the key lived under `sprout`. SSH looked in the wrong place and found nothing.

Then when we tried to fix it with `sudo tee`, we accidentally wrote a file owned by root inside `sprout`'s `.ssh/` folder — so `sprout` couldn't update it:

```
Operation not permitted
```

Two separate problems. Both caused by not thinking clearly about *which user is acting*.

---

## The Mental Model

```
/home/mbc/.ssh/          ← mbc's keyring (empty)
/opt/sprout/.ssh/        ← sprout's keyring (has the key)
```

When you run a command, it uses the current user's keyring. Running as `mbc` means GitHub never sees `sprout`'s key — it's not yours to offer.

**The fix:** always act as the user who owns the key.

```bash
sudo -u sprout ssh -T git@github.com
sudo -u sprout git clone git@github.com:org/repo.git /opt/sprout/app
```

---

## File Permissions — SSH Enforces These

SSH is paranoid by design. It will silently refuse to use a key if the permissions are wrong.

```
drwx------  .ssh/            700  owner only
-rw-------  id_ed25519       600  private key — owner only, no exceptions
-rw-r--r--  id_ed25519.pub   644  public key — fine to be readable
-rw-r--r--  known_hosts      644
-rw-------  authorized_keys  600
```

**Why it's strict:** if your private key is world-readable, any other local user could copy it. SSH refuses rather than silently accept the risk.

### Break it and see:

```bash
chmod 777 ~/.ssh/id_ed25519
ssh -T git@github.com
# WARNING: UNPROTECTED PRIVATE KEY FILE!
# Permissions 0777 for '...id_ed25519' are too open.
# Ignored.
```

### Fix it:

```bash
chmod 600 ~/.ssh/id_ed25519
ssh -T git@github.com
# Hi username! You've successfully authenticated...
```

### Fix ownership for a service account:

```bash
sudo chown -R sprout:sprout /opt/sprout/.ssh
sudo chmod 700 /opt/sprout/.ssh
sudo chmod 600 /opt/sprout/.ssh/id_ed25519
sudo chmod 644 /opt/sprout/.ssh/id_ed25519.pub
sudo chmod 644 /opt/sprout/.ssh/known_hosts
```

---

## Diagnosing a Failure

`ssh -vT` shows exactly which keys were tried and why they were rejected. It's always your first move.

```bash
ssh -vT git@github.com 2>&1 | grep -E "identity|Offering|denied|Authenticated"
```

Common errors and what they mean:

| Error | What's wrong |
|---|---|
| `Permission denied (publickey)` | No matching key found, or wrong user |
| `Operation not permitted` | File owned by someone else |
| `UNPROTECTED PRIVATE KEY FILE` | Permissions too loose |
| `Host key verification failed` | Server fingerprint changed — or MITM |

---

## `known_hosts` — The Other Trip Wire

The first time you connect to a host, SSH records its fingerprint in `~/.ssh/known_hosts`. Future connections are checked against it. If the fingerprint changes, SSH blocks the connection (that's intentional — it's protecting you from a potential MITM attack).

The bug: we wrote `known_hosts` with `sudo tee`, so root owned it. Then when `sprout` tried to update it on the next connection, it couldn't write to its own file.

**Rule:** never use bare `sudo` to create files inside another user's `.ssh/`. Use `sudo -u USERNAME` to write as that user.

---

## Hands-On

Work through these in order:

1. Generate a key as a test user
   ```bash
   sudo -u testuser ssh-keygen -t ed25519 -C "test" -f /home/testuser/.ssh/id_ed25519 -N ""
   ```

2. Break the permissions and observe the failure
   ```bash
   sudo chmod 644 /home/testuser/.ssh/id_ed25519
   sudo -u testuser ssh -T git@github.com
   ```

3. Fix it and reconnect
   ```bash
   sudo chmod 600 /home/testuser/.ssh/id_ed25519
   sudo -u testuser ssh -T git@github.com
   ```

4. Write a script that checks `.ssh/` permissions and reports problems

---

## The Three Rules

1. **Act as the user who owns the key.** Use `sudo -u USERNAME`, not bare `sudo`.
2. **Private key is 600. `.ssh/` dir is 700.** SSH won't negotiate on this.
3. **`ssh -vT` first.** It tells you exactly what failed and why.
