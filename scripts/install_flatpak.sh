#!/bin/bash
# Installs Flatpak apps with progress and comment support.
set -e

# --- Style helpers ---
yellow() { echo -e "\033[1;33m$1\033[0m"; }
cyan()   { echo -e "\033[1;36m$1\033[0m"; }
green()  { echo -e "\033[1;32m$1\033[0m"; }
red()    { echo -e "\033[1;31m$1\033[0m"; }

# --- File location ---
DATA_DIR="$(cd "$(dirname "$0")/../data" && pwd)"
FLATPAK_FILE="$DATA_DIR/flatpak_apps.txt"

if [ ! -f "$FLATPAK_FILE" ]; then
    echo -e "$(yellow)⚠️  flatpak_apps.txt not found, skipping.${RESET}"
    exit 0
fi

# --- Read and install apps ---
# Use sed to remove comments (#) and blank lines
APPS=($(sed '/^#/d;/^\s*$/d' "$FLATPAK_FILE"))
TOTAL=${#APPS[@]}

if [ $TOTAL -eq 0 ]; then
    echo -e "$(yellow)⚠️  No Flatpak apps listed in $FLATPAK_FILE.${RESET}"
    exit 0
fi

echo -e "Found $(cyan "$TOTAL") Flatpak apps to install."
count=0
for app in "${APPS[@]}"; do
    count=$((count + 1))
    echo -e "  $(cyan "[$count/$TOTAL]") Installing $(yellow "$app")..."
    
    # Let Flatpak show its own progress bar
    if sudo flatpak install -y flathub "$app"; then
        echo -e "  $(green)✅ Successfully installed $app.${RESET}"
    else
        echo -e "  $(red)⚠️ Failed to install $app.${RESET}"
    fi
    echo "" # Add spacing
done

echo -e "$(green)✅ All Flatpak apps processed!${RESET}"
