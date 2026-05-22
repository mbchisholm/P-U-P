# Module 00 — Windows Setup (WSL)

You're going to install WSL2 — the Windows Subsystem for Linux. It runs a real Linux environment inside Windows. After this setup, ~95% of the curriculum is identical to the Mac path: same bash, same commands, same tools.

This takes one extra step and possibly one reboot. It's worth it.

---

## What is WSL?

WSL lets you run Linux inside Windows without dual-booting or a VM. You get a real bash shell, a real Linux filesystem, and access to the same tools every developer uses. VS Code connects to it seamlessly.

This is the standard way professional Windows developers work.

---

## Step 1 — Install WSL2

Open **PowerShell as Administrator**:
1. Press the Windows key
2. Type `PowerShell`
3. Right-click → **Run as administrator**

Run:

```powershell
wsl --install
```

This installs WSL2 with Ubuntu by default. It will ask you to reboot.

**Reboot now.** After reboot, Ubuntu will finish setting up and ask you to create a Linux username and password.

> Your Linux username doesn't have to match your Windows username. Pick something simple — all lowercase.
> Your Linux password is separate from your Windows password. You'll use it for `sudo` commands. Remember it.

**Check:**
```bash
uname -a
```
You should see output containing `Linux` and `Ubuntu`.

---

## Step 2 — Install Windows Terminal (recommended)

Windows Terminal is a modern terminal emulator that handles WSL, PowerShell, and CMD in tabs.

1. Open the Microsoft Store
2. Search for **Windows Terminal**
3. Install it

After install, open Windows Terminal. In the dropdown (arrow next to the `+` tab), select **Ubuntu**. This opens your WSL shell.

From here, all commands in this workshop run in the Ubuntu WSL shell — not PowerShell.

---

## Step 3 — Install git inside WSL

```bash
sudo apt update
sudo apt install git -y
```

Configure git:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

**Check:**
```bash
git --version
git config --global user.name
```

---

## Step 4 — Create your Developer folder

```bash
mkdir -p ~/Developer
```

> Your WSL home directory is at `\\wsl$\Ubuntu\home\<your-username>` from Windows Explorer — but you'll rarely need to go there. Work from the WSL terminal.

---

## Step 5 — Clone this repo

```bash
cd ~/Developer
git clone https://github.com/mbchisholm/P-U-P.git power-user-principles
cd power-user-principles
```

**Check:**
```bash
ls
```

You should see: `modules/  scripts/  templates/  reference/  README.md`

---

## Step 6 — Run the verify script

```bash
bash modules/00-start-here/verify.sh
```

All green? Go back to [README.md](README.md).

---

## Troubleshooting

**"wsl --install" says WSL is already installed**
Run `wsl --update` to make sure you have WSL2, then open Ubuntu from the Start menu.

**Ubuntu asks for a username/password but I can't remember setting one**
Run `ubuntu config --default-user root` in PowerShell, then set a new password from inside WSL with `passwd <username>`.

**"Permission denied" or "sudo: not found"**
You're not in WSL — you may be in PowerShell. Open Windows Terminal and switch to the Ubuntu tab.

**Files I create in WSL don't show up in Windows Explorer**
They do, they're just in a different place: `\\wsl$\Ubuntu\home\<username>\`. You can also run `explorer.exe .` from WSL to open the current directory in Explorer.
