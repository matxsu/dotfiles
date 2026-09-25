#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

dotfiles() {
    /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

echo "==> Installing paru (AUR helper) if missing"
if ! command -v paru &> /dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru-install
    (cd /tmp/paru-install && makepkg -si --noconfirm)
    rm -rf /tmp/paru-install
fi

echo "==> Installing official packages"
sudo pacman -S --needed - < "$DOTFILES_DIR"/../packages/pkglist.txt 2>/dev/null || \
    pacman -S --needed - < ~/packages/pkglist.txt

echo "==> Installing AUR packages"
paru -S --needed - < ~/packages/aur-pkglist.txt

echo "==> Backing up conflicting dotfiles"
mkdir -p "$BACKUP_DIR"
dotfiles checkout 2>&1 | grep -E "^\s+\." | awk '{print $1}' | while read -r file; do
    mkdir -p "$BACKUP_DIR/$(dirname "$file")"
    mv "$HOME/$file" "$BACKUP_DIR/$file"
done

echo "==> Checking out dotfiles"
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

echo "==> Done. Add this alias to your shell rc:"
echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'"
