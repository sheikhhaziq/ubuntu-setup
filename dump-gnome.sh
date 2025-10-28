#!/usr/bin/env bash
set -e
echo "💾 Dumping GNOME settings..."
dconf dump / > gnome-settings.dconf
echo "✅ GNOME settings saved."
