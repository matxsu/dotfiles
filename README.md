# dotfiles

Personal dotfiles for my Arch Linux setup: niri (Wayland compositor) with the Noctalia shell.

## Stack

- **WM/Compositor:** niri (scrollable tiling, Wayland)
- **Shell/Bar/Launcher:** Noctalia (quickshell) + Walker (app launcher)
- **Terminal:** kitty
- **Shell:** zsh + Starship prompt
- **Editor:** Neovim (LazyVim-based config)
- **File manager:** Yazi
- **Color scheme:** pywal16
- **Font:** JetBrains Mono Nerd Font

## Requirements

- A fresh Arch Linux install
- `git`, `base-devel` (for building AUR packages)

## Installation

```bash
git clone --bare https://github.com/matxsu/dotfiles.git ~/.dotfiles
./setup.sh
```

`setup.sh` will:
1. Install `paru` (AUR helper) if not present
2. Install packages from `packages/pkglist.txt` and `packages/aur-pkglist.txt`
3. Back up any conflicting existing dotfiles to `~/.dotfiles-backup/`
4. Checkout the dotfiles into `$HOME`
5. Set up the `dotfiles` git alias for future management

## Managing dotfiles after install

This repo uses the bare-repo technique (no symlinks). Add the alias to your shell rc if not already present:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Then use it like a normal git repo:

```bash
dotfiles status
dotfiles add ~/.config/somefile
dotfiles commit -m "..."
dotfiles push
```

## Manual steps not covered by the install script

- GTK theme / icon theme (set manually via `nwg-look` or similar if desired)
- pywal color generation on first wallpaper set: `wal -i /path/to/wallpaper`
- Enable any user systemd services you use (none required by default)

## Notes

- Hostname/username in some configs are hardcoded to my machine (`kashyyyk`/`matisu`) — check `.config/niri/config.kdl` and adjust if needed.
- `.bak*` files are gitignored; if you see one tracked, it's stale.
