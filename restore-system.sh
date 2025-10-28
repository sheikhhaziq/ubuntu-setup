#!/usr/bin/env bash
set -e
echo "🚀 Restoring Ubuntu GNOME setup..."

sudo apt update
if [ -f packages/apt.txt ]; then
  echo "📦 Installing APT packages..."
  xargs -a packages/apt.txt sudo apt install -y
fi

bash flatpak-install.sh
bash gnome-settings.sh

if [ -s packages/missing.txt ]; then
  echo "⚠️ Some packages were not found in APT or Flathub:"
  cat packages/missing.txt
fi

echo "✅ System restore complete!"
