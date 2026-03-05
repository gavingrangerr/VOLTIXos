# Editing Voltix OS

A guide to customizing your Voltix OS base.

## Quick Edits

| What to change | File |
|----------------|------|
| Boot splash text | `plymouth/voltix/voltix.script` |
| Login message (MOTD) | `etc/motd` |
| Shell prompt & aliases | `config/bashrc-voltix` |
| Installed software | `packages.txt` |
| Hostname | `scripts/install.sh` (search for `voltix-os`) |

## Plymouth Theme

Edit `plymouth/voltix/voltix.script`:
- `text_red`, `text_green`, `text_blue` — RGB (0–1) for text color
- `font` — e.g. `"Sans Bold 24"`, `"Monospace 16"`
- Title text: change `"VOLTIX OS"` in `Image.Text(...)`

Add background images by placing PNGs in `plymouth/voltix/` and referencing them in the script with `Image("filename.png")`.

## MOTD (Message of the Day)

Use [ASCII art generators](https://patorjk.com/software/taag/) for custom logos. Paste into `etc/motd`.

## Packages

Add packages to `packages.txt` (one per line, `#` for comments). Re-run the install script or:

```bash
sudo xargs -a packages.txt apt-get install -y
```

## Re-applying Changes

After editing config files, either:
1. Re-run `sudo ./scripts/install.sh` (idempotent for most steps), or
2. Manually copy files to their targets (see install script for paths)

## Building a Custom Image (Advanced)

To create a flashable Voltix OS image instead of installing on a running Pi:

1. **rpi-image-gen**: Clone [rpi-image-gen](https://github.com/raspberrypi/rpi-image-gen), add a Voltix layer that copies these files and runs the package install
2. **Buildroot**: Add a custom overlay with `config/`, `etc/`, `plymouth/` and post-build scripts
