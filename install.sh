#!/usr/bin/env bash
set -e

echo "🌿 Starting Ubuntu GNOME setup restore..."

sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl chezmoi flatpak gnome-shell-extensions dconf-cli

chezmoi init https://github.com/sheikhhaziq/ubuntu-setup.git
chezmoi apply

bash apt-install.sh
bash flatpak-install.sh
bash gnome-settings.sh

mkdir -p ~/.config/systemd/user
cp auto-sync.service auto-sync.timer ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now auto-sync.timer || true

echo "✅ Setup complete! All apps, GNOME settings, and Flatpaks restored."
