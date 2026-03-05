# Voltix OS

A custom Raspberry Pi 5 OS with a hacker-style terminal interface. Two ways to run it:

| Method | What you get |
|--------|--------------|
| **Buildroot** | A new Linux distro built from scratch — kernel, rootfs, everything |
| **Raspberry Pi OS** | Customize existing Raspberry Pi OS Lite (faster setup) |

---

## Method 1: Build from Scratch (Buildroot)

Build a complete Voltix OS image — your own Linux distribution, not based on Raspberry Pi OS.

### Option A: GitHub Actions (no Linux needed)

Push to `main` or trigger manually from the **Actions** tab. After ~1–2 hours, download the `voltix-os-image` artifact (contains `sdcard.img`). Works on Mac/Windows — build runs in the cloud.

### Option B: Local Linux build

Requirements: Linux (Ubuntu/Debian), ~15GB disk, 1–2 hours.

Build dependencies:

```bash
sudo apt update
sudo apt install -y build-essential libncurses-dev git wget unzip rsync python3 bc file
```

### Build

```bash
git clone https://github.com/gavingrangerr/VOLTIXos.git
cd VOLTIXos/buildroot
./build.sh
```

First build takes **1–2 hours**. Output: `build/output/images/sdcard.img`

### Flash to SD card

```bash
sudo dd if=build/output/images/sdcard.img of=/dev/sdX bs=4M status=progress conv=fsync
```

Replace `/dev/sdX` with your SD card device (e.g. `/dev/sda`). **Warning:** This erases the entire device.

### First boot

- Login: **root** (no password — run `passwd` immediately)
- Hostname: **voltix-os**
- Preinstalled: htop, nmap, vim, tmux, neofetch, curl, wget, OpenSSH, etc.

---

## Method 2: Customize Raspberry Pi OS (Quick)

1. Flash **Raspberry Pi OS Lite** (64-bit) to an SD card
2. Boot the Pi and run:
   ```bash
   git clone https://github.com/gavingrangerr/VOLTIXos.git
   cd VOLTIXos
   sudo ./scripts/install.sh
   ```
3. Reboot

---

## Project Structure

```
VOLTIXos/
├── buildroot/           # Build-from-scratch (Buildroot)
│   ├── build.sh         # Build script
│   ├── configs/         # voltix_rpi5_defconfig
│   └── overlay/         # Files baked into the image
├── config/              # Config for Raspberry Pi OS method
├── plymouth/            # Boot splash theme
├── scripts/             # install.sh for Raspberry Pi OS
├── etc/                 # MOTD, etc.
└── packages.txt         # apt packages (Raspberry Pi OS method)
```

## Customization

- **Buildroot overlay**: Edit `buildroot/overlay/` — these files go into the final image
- **Defconfig**: Edit `buildroot/configs/voltix_rpi5_defconfig` for packages and options
- **Raspberry Pi OS**: See `EDITING.md`
