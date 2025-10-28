#!/usr/bin/env bash
set -e
echo "📦 Setting up Flatpak & Flathub..."
sudo apt install -y flatpak gnome-software-plugin-flatpak
if ! flatpak remote-list | grep -q flathub; then
  echo "🔗 Adding Flathub repo..."
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi
if [ -f packages/flatpak.txt ]; then
  echo "📦 Installing Flatpaks..."
  xargs -a packages/flatpak.txt -I {} flatpak install -y flathub {}
else
  echo "⚠️ No flatpaks.txt found — skipping."
fi
