#!/usr/bin/env bash
set -e
echo "📦 Dumping installed apt and Flatpak packages..."

# APT (manual user-installed packages only)
apt-mark showmanual | sort > packages.txt

# FLATPAK (apps only)
flatpak list --app --columns=application | sort > flatpaks.txt

echo "✅ Package lists updated."
