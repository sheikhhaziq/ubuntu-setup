#!/bin/bash
# Removes Snap packages with progress and comment support.
set -e

# --- Style helpers ---
yellow() { echo -e "\033[1;33m$1\033[0m"; }
cyan()   { echo -e "\033[1;36m$1\033[0m"; }
green()  { echo -e "\033[1;32m$1\033[0m"; }
red()    { echo -e "\033[1;31m$1\033[0m"; }

# --- File location ---
DATA_DIR="$(cd "$(dirname "$0")/../data" && pwd)"
SNAP_REMOVE_FILE="$DATA_DIR/remove_snap.txt"

if ! command -v snap &> /dev/null; then
    echo -e "$(yellow)Snap not installed, skipping removal.${RESET}"
    exit 0
fi

if [ ! -f "$SNAP_REMOVE_FILE" ]; then
    echo -e "$(yellow)⚠️  remove_snap.txt not found, skipping.${RESET}"
    exit 0
fi

# --- Read and remove apps ---
SNAPS=($(sed '/^#/d;/^\s*$/d' "$SNAP_REMOVE_FILE"))
TOTAL=${#SNAPS[@]}

if [ $TOTAL -eq 0 ]; then
    echo -e "$(yellow)⚠️  No Snap packages listed for removal.${RESET}"
    exit 0
fi

echo -e "Found $(cyan "$TOTAL") Snap packages to remove."
count=0
for snap in "${SNAPS[@]}"; do
    count=$((count + 1))
    echo -e "  $(cyan "[$count/$TOTAL]") Checking for $(yellow "$snap")..."
    
    # Check if snap is actually installed before trying to remove
    if snap list | grep -qE "^$snap\s"; then
        echo -e "    Removing $(yellow "$snap")..."
        sudo snap remove --purge "$snap"
    else
        echo -e "    $(yellow "$snap") not installed, skipping."
    fi
done

echo -e "$(green)✅ All Snap packages processed for removal!${RESET}"
