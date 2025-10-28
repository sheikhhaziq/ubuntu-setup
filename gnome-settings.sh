#!/usr/bin/env bash
set -e
echo "🖼️ Restoring GNOME settings..."
if [ -f gnome-settings.dconf ]; then
  dconf load / < gnome-settings.dconf
else
  echo "⚠️ No gnome-settings.dconf found — skipping."
fi
