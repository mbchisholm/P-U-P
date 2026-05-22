# Module 11 — SSH Into a Pi

> **You'll be able to:** Find a Raspberry Pi on your local network, SSH into it with your key, and run a program on a computer that's not in front of you.
> **Time:** ~45 min
> **Prereqs:** Module 04

## Why this matters

SSH is the interface to every server you'll ever run. The Pi is just a tangible, physical version of a cloud instance — same Linux, same commands, same SSH. Once you've done this with a Pi on your desk, you've done it conceptually with an AWS EC2 instance, a DigitalOcean droplet, or a bare-metal server in a rack somewhere. The only difference is the IP address.

## Setup

**You need a Raspberry Pi** for this module — any model, running Raspberry Pi OS. If you don't have one, this module is marked optional and you can come back to it.

Connect the Pi to the same WiFi network as your laptop before starting.

```bash
cd ~/Developer/power-user-principles/modules/11-pi-ssh
```

---

## Find the Pi on Your Network

Your Pi has an IP address assigned by your router. Find it:

```bash
bash scan.sh
```

`scan.sh` runs an nmap scan of your local subnet (`192.168.1.0/24`) and lists every device that responds, with their MAC addresses.

Look for a line containing `Raspberry Pi Foundation` in the MAC address lookup. That's your Pi.

> If nmap isn't installed: `brew install nmap` (Mac) or `sudo apt install nmap` (WSL).

Alternatively, if your Pi has mDNS enabled (Raspberry Pi OS default), you can reach it by hostname:

```bash
ping raspberrypi.local     # or whatever you named it
```

---

## Copy Your SSH Key to the Pi

On your first connection, you'll need the Pi's password. After copying your key, you'll never need it again.

The default credentials for Raspberry Pi OS are username `pi`, password `raspberry`. (You should change this after the module.)

```bash
ssh-copy-id pi@raspberrypi.local
```

This appends your public key to `~/.ssh/authorized_keys` on the Pi. From now on, SSH uses your key instead of a password.

If `ssh-copy-id` isn't available (some WSL installs):

```bash
cat ~/.ssh/id_ed25519.pub | ssh pi@raspberrypi.local "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

---

## SSH In

```bash
ssh pi@raspberrypi.local
```

You're now controlling a computer across the room. No display attached to the Pi. No keyboard. Just text over the network.

```bash
pwd          # /home/pi
ls           # same commands as your laptop
uname -a     # Linux. Same OS as most servers in the world.
df -h        # disk usage
```

> 💡 Everything you learned in Modules 01–08 works exactly the same here. You're in a bash shell on a Linux machine. The commands are identical.

---

## What You're Looking At

| What we did | What it maps to at scale |
|---|---|
| `raspberrypi.local` | A domain name (`yourapp.com`) |
| Pi on local WiFi | A cloud instance (EC2, DigitalOcean, etc.) |
| Port 22 (SSH) | Same port on every Linux server |
| `uname -a` showing Linux | Same OS as AWS, GCP, most of the internet |

---

## Run the Pi Setup Script

From inside your SSH session on the Pi, run the setup script included in this module:

```bash
# (you're still connected via SSH)
curl -fsSL https://raw.githubusercontent.com/mbchisholm/P-U-P/main/modules/11-pi-ssh/pi-setup.sh | bash
```

Or clone the repo onto the Pi and run it locally:

```bash
git clone https://github.com/mbchisholm/P-U-P.git power-user-principles
bash power-user-principles/modules/11-pi-ssh/pi-setup.sh
```

---

## Run a Program on the Pi

While still SSH'd in, run a simple Python script:

```bash
python3 -c "import socket; print(f'Running on {socket.gethostname()}')"
```

You're executing Python on the Pi from your laptop. The Pi's hostname should print — not your laptop's.

**Try it:** Start Python's built-in HTTP server on the Pi:

```bash
python3 -m http.server 8080
```

From your laptop (in a new terminal tab), visit `http://raspberrypi.local:8080` in your browser. You should see the Pi's home directory listed.

Press `ctrl+c` to stop the server on the Pi.

---

## Ports

An IP address gets you to a device. A port gets you to a specific service on that device.

```
raspberrypi.local:22     ← SSH
raspberrypi.local:8080   ← the HTTP server you just ran
raspberrypi.local:5000   ← your Flask app (if you deploy it here)
```

`ctrl+c` on the Pi kills the process. Anyone trying to connect to port 8080 from your laptop now gets "connection refused." That's the process no longer listening.

---

## Disconnect

```bash
exit
```

Or press `ctrl+d`. You're back on your laptop.

---

## Change the Default Password

Still good security hygiene, even on a local Pi:

```bash
ssh pi@raspberrypi.local
passwd    # it'll ask for the current password, then the new one
exit
```

---

## Verify

Run this from your laptop (not from inside the SSH session):

```bash
bash modules/11-pi-ssh/verify.sh
```

---

## What you can do now

You can SSH into any computer that has your public key and is reachable on a network. You've run a program on a computer that isn't in front of you. That's the same operation as every deployment pipeline in production.

## Stretch

- Set up passwordless `sudo` on the Pi so scripts can run system commands without a prompt
- Clone your Module 09 weather project onto the Pi and run it there
- Set up the Pi to run your HTTP server on boot using `systemd`
- Explore `tmux` — a terminal multiplexer that keeps processes running after you disconnect
