# Networking and the Raspberry Pi

Everything on a network has an address. Your laptop, your phone, the Pi — each one gets an IP assigned by the router when it connects. Understanding that, plus how names map to addresses, unlocks SSH, web hosting, and every server interaction you'll ever do.

---

## IP Addresses

An IP address identifies a device on a network.

```
192.168.1.1     ← typically the router itself
192.168.1.50    ← your laptop
192.168.1.51    ← the Pi
192.168.1.x     ← everyone on the same WiFi
```

The first three octets (`192.168.1`) identify the local network. The last one identifies the device. This is a private address space — it only works within your local network.

Find your own IP:

```bash
ipconfig getifaddr en0    # Mac WiFi
ip addr show              # Linux
```

---

## Hostnames and `.local`

You can SSH into a device by IP address, but IP addresses change. A hostname stays the same.

`workshop.local` resolves to the Pi's IP address using mDNS (multicast DNS) — a protocol that lets devices on a local network advertise and look up names without a central DNS server.

```bash
ssh pi@workshop.local
# same as
ssh pi@192.168.1.51
```

The Pi advertises its hostname on the network. Your laptop listens, learns the mapping, connects.

This is the same idea as regular DNS (`google.com` → `142.250.80.46`), just local and automatic.

---

## SSH In

```bash
ssh pi@workshop.local
```

You're now controlling a computer across the room. No display attached to the Pi. No keyboard. Just text over the network.

```bash
pwd     # /home/pi
ls      # same commands as your laptop
uname -a  # Linux. Same OS as AWS, GCP, most servers in the world.
```

This is the normal way to operate a server. The Pi is just a tangible version of an EC2 instance or a DigitalOcean droplet.

---

## The Network Scan

```bash
bash scan.sh
```

This runs `nmap -sn` against your local subnet — it sends a ping to every address in the `192.168.1.0/24` range and records who responds.

```
Nmap scan report for workshop.local (192.168.1.51) [host up]
  MAC Address: B8:27:EB:xx:xx:xx (Raspberry Pi Foundation)
Nmap scan report for 192.168.1.62 [host up]
  MAC Address: A4:C3:F0:xx:xx:xx (Apple)
```

Every device shows up. The MAC address tells you the manufacturer. Someone will recognize their phone.

This is how network engineers see a room. Every enterprise monitoring tool — Wireshark, Nagios, Datadog — is built on the same fundamentals.

---

## Ports

An IP address gets you to a device. A port gets you to a specific service on that device.

```
192.168.1.51:5000    ← the Pi, port 5000 (your Flask app)
192.168.1.51:22      ← the Pi, port 22 (SSH)
192.168.1.51:80      ← port 80 (HTTP)
192.168.1.51:443     ← port 443 (HTTPS)
```

When you run `python3 app.py` on the Pi and it says "Serving on port 5000," that means: any device that can reach this IP can connect to port 5000 and get a response.

From any device on the WiFi: `http://workshop.local:5000`

---

## Deploy to the Pi

```bash
# On the Pi, after SSH-ing in:
git clone git@github.com:username/workshop-project.git
cd workshop-project/project/starter
source .venv/bin/activate
python3 app.py
```

From your phone: `http://workshop.local:5000`

The app running on a $15 chip is accessible to every device in the room. This is what "hosting" means — a machine running a process that listens on a port and responds to requests.

---

## What Each Layer Maps To

| What we did | What it maps to at scale |
|---|---|
| `workshop.local` | A domain name registered through a registrar |
| Pi on the local WiFi | A VPS or cloud instance |
| `git clone` to deploy | GitHub Actions or a CI/CD pipeline |
| Port 5000 | Port 443 (add a domain + TLS cert) |
| In-memory messages | A real database |
| One app, one Pi | Containers, load balancers, Kubernetes |

Every layer is the same concept at a different scale. You've seen the layers.

---

## Hands-On

1. SSH into the Pi: `ssh pi@workshop.local`. Walk around. Run `ls`, `pwd`, `df -h`.
2. Run `bash scan.sh`. Find your phone. Find someone else's laptop.
3. Deploy your project to the Pi. Confirm it's accessible from your phone.
4. Run `sudo lsof -i :5000` on the Pi — see the process listening on that port.
5. Kill `app.py` with `ctrl+c`. Try loading the page from your phone. What happens?

---

## The Three Rules

1. **IP addresses change; hostnames don't.** Use `workshop.local` not the IP.
2. **Every service has a port.** You can't just "connect to a computer" — you connect to a specific port on it.
3. **SSH is your interface to every server you'll ever run.** Learn to be comfortable at a remote prompt.
