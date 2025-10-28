#!/usr/bin/env bash
set -e
echo "🌿 Starting Ubuntu setup..."

sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl flatpak gnome-shell-extensions dconf-cli
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

chezmoi init https://github.com/sheikhhaziq/ubuntu-setup.git
chezmoi apply

bash gnome-settings.sh
bash restore-system.sh

mkdir -p ~/.config/systemd/user
cp auto-sync.service auto-sync.timer ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now auto-sync.timer || true

echo "✅ Setup complete! Log out and back in for all GNOME settings to apply."
