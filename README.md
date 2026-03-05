# Voltix OS

A custom Raspberry Pi 5 OS with a hacker-style terminal interface. Built on Raspberry Pi OS Lite, fully customizable.

## Quick Start

1. **Flash** Raspberry Pi OS Lite (64-bit) to an SD card using [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. **Boot** the Pi and run the installer:
   ```bash
   git clone https://github.com/YOUR_USER/VOLTIXos.git
   cd VOLTIXos
   sudo ./scripts/install.sh
   ```
3. **Reboot** to see the full Voltix OS experience

## Project Structure

```
VOLTIXos/
├── config/           # System configuration files
├── plymouth/         # Boot splash theme
├── scripts/          # Installation and setup scripts
├── etc/              # Files to deploy to /etc/
├── packages.txt      # Software to install
└── README.md
```

## Customization

- **Boot splash**: Edit `plymouth/voltix/voltix.plymouth` and PNGs in `plymouth/voltix/`
- **Login message**: Edit `etc/motd`
- **Shell prompt**: Edit `config/bashrc-voltix`
- **Packages**: Add/remove from `packages.txt`

## Requirements

- Raspberry Pi 5 (or Pi 4) with Raspberry Pi OS Lite 64-bit
