#!/usr/bin/env bash
set -e
echo "📦 Dumping installed packages for Ubuntu + GNOME..."

mkdir -p packages

# --- APT packages ---
echo "🔍 Collecting APT packages..."
apt-mark showmanual > packages/_apt_all.txt
> packages/apt.txt
> packages/missing.txt
while read -r pkg; do
  if apt-cache show "$pkg" >/dev/null 2>&1; then
    echo "$pkg" >> packages/apt.txt
  else
    echo "$pkg" >> packages/missing.txt
  fi
done < packages/_apt_all.txt

# --- Flatpak packages ---
echo "🔍 Collecting Flatpak packages..."
flatpak list --app --columns=application > packages/_flatpak_all.txt
> packages/flatpak.txt
while read -r pkg; do
  if flatpak search "$pkg" --columns=application | grep -q "$pkg"; then
    echo "$pkg" >> packages/flatpak.txt
  else
    echo "$pkg" >> packages/missing.txt
  fi
done < packages/_flatpak_all.txt

rm packages/_apt_all.txt packages/_flatpak_all.txt

echo "✅ Package lists updated:"
echo "   - packages/apt.txt (APT)"
echo "   - packages/flatpak.txt (Flatpak)"
echo "   - packages/missing.txt (Not in repo)"
