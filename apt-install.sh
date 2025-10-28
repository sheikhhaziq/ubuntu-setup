#!/usr/bin/env bash
set -e
echo "📦 Installing APT packages..."
if [ -s packages.txt ]; then
  xargs -a packages.txt sudo apt install -y
else
  echo "⚠️ No packages.txt found or it's empty."
fi
