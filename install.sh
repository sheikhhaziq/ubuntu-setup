#!/usr/bin/env bash
set -e
echo "🌿 Starting Ubuntu setup..."

sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl flatpak gnome-shell-extensions dconf-cli

# 🧩 Install chezmoi safely
if command -v chezmoi >/dev/null 2>&1; then
  echo "✅ chezmoi already installed."
elif snap list | grep -q chezmoi; then
  echo "✅ chezmoi already installed via Snap."
else
  echo "📥 Installing chezmoi..."
  if command -v snap >/dev/null 2>&1; then
    sudo snap install chezmoi --classic
  else
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
  fi
fi

chezmoi init https://github.com/sheikhhaziq/ubuntu-setup.git
chezmoi apply

bash gnome-settings.sh
bash restore-system.sh

mkdir -p ~/.config/systemd/user
cp auto-sync.service auto-sync.timer ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now auto-sync.timer || true

echo "✅ Setup complete! Log out and back in for all GNOME settings to apply."
