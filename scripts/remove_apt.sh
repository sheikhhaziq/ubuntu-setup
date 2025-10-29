#!/bin/bash
# Removes APT packages with progress and comment support.
set -e


# --- Style helpers ---
yellow() { echo -e "\033[1;33m$1\033[0m"; }
cyan()   { echo -e "\033[1;36m$1\033[0m"; }
green()  { echo -e "\033[1;32m$1\033[0m"; }

# --- File location ---
DATA_DIR="$(cd "$(dirname "$0")/../data" && pwd)"
APT_REMOVE_FILE="$DATA_DIR/remove_apt.txt"

if [ ! -f "$APT_REMOVE_FILE" ]; then
    echo -e "$(yellow)⚠️  remove_apt.txt not found, skipping.${RESET}"
    exit 0
fi

# --- Read and remove apps ---
PACKAGES=($(sed '/^#/d;/^\s*$/d' "$APT_REMOVE_FILE"))
TOTAL=${#PACKAGES[@]}

if [ $TOTAL -eq 0 ]; then
    echo -e "$(yellow)⚠️  No APT packages listed for removal.${RESET}"
    exit 0
fi

echo -e "Found $(cyan "$TOTAL") APT packages to remove."
count=0
for pkg in "${PACKAGES[@]}"; do
    count=$((count + 1))
    echo -e "  $(cyan "[$count/$TOTAL]") Removing $(yellow "$pkg")..."
    sudo apt remove -y "$pkg" > /dev/null
done

echo -e "\n$(cyan "Running apt autoremove...${RESET}")"
sudo apt autoremove -y > /dev/null

echo -e "$(green)✅ All APT packages processed for removal!${RESET}"
