#!/usr/bin/env bash
set -e
echo "📦 Installing Flatpaks..."
if [ -s flatpaks.txt ]; then
  grep -v '^#' flatpaks.txt | while read -r pkg; do
    [ -n "$pkg" ] && flatpak install -y "$pkg" || true
  done
else
  echo "⚠️ No flatpaks.txt found or it's empty."
fi
