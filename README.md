# Jimmy's Dot Files

Git repo store for all the configs I might need

## Setup Scripts

I have setup scripts for various operating systems, usually to setup the environments I run under them. These are all found within the scripts folder.

### Ubuntu (and Debian derivatives)

This script was originally designed for my Ubuntu WSL environment for all my dev. It installs various tools and CLIs I've needed for work and shell customistations.

Run a terminal and run the `setup-linux.sh` script. It will require sudo access.

### Windows

This sets up a basic Windows install with Firefox, VSCode, and a couple of developer tools. It does tinker with GPO, so don't run directly on a corporate device.

Run a Windows PowerShell as admin, and run the `setup-windows.ps1` script.

#### Extra Info

I haven't scripted these parts, I only use them sometimes.

- WinGet is not included on LTSC, I prefer the Store method to keep it up to date. You can install the Store and App Installer by:
  1. Reinstall the store using `wsreset -i`
  2. Install App Installer with this URI: `ms-windows-store://pdp?&productid=9nblggh4nns1`
  3. Proceed with the usual script, which will install Terminal.
- BgInfo isn't part of the base script, you can install it via WinGet: `winget install Microsoft.Sysinternals.BGInfo`
- Copy the `windows` folder to `C:\Baseline` to get baseline configs.
- Create a new shortcut in the Startup folder that directs to: `Bginfo C:\Baseline\config.bgi /timer:0`

### Mac

Heavily WIP, and therefore not recommended, at `setup-macos.sh`.

## Other Configs

There are likely many other configs in here, some that I recall from when last updating this README:
- Neovim configs are at `.config/nvim`
- Zsh configs are within `.zshrc` and potentially `.p10k.zsh` for Powerline10k.
- Windows based configs for duplicating dev environments in `windows/`



