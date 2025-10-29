#!/bin/bash
# Installs APT packages with progress and comment support.
set -e


# --- Style helpers ---
yellow() { echo -e "\033[1;33m$1\033[0m"; }
cyan()   { echo -e "\033[1;36m$1\033[0m"; }
green()  { echo -e "\033[1;32m$1\033[0m"; }

# --- File location ---
DATA_DIR="$(cd "$(dirname "$0")/../data" && pwd)"
APT_FILE="$DATA_DIR/apt_apps.txt"

if [[ ! -f "$APT_FILE" ]]; then
    echo -e "$(yellow)⚠️  apt_apps.txt not found, skipping.${RESET}"
    exit 0
fi

# --- Read and install apps ---
# Use sed to remove comments (#) and blank lines
PACKAGES=($(sed '/^#/d;/^\s*$/d' "$APT_FILE"))
TOTAL=${#PACKAGES[@]}

if [ $TOTAL -eq 0 ]; then
    echo -e "$(yellow)⚠️  No APT packages listed in $APT_FILE.${RESET}"
    exit 0
fi

echo -e "Found $(cyan "$TOTAL") APT packages to install."
count=0
for pkg in "${PACKAGES[@]}"; do
    count=$((count + 1))
    echo -e "  $(cyan "[$count/$TOTAL]") Installing $(yellow "$pkg")..."
    sudo apt install -y "$pkg" > /dev/null
done

echo -e "$(green)✅ All APT packages processed!${RESET}"
