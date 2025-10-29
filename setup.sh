#!/bin/bash
# =====================================================================
# 🚀 Ubuntu Setup Wizard (Upgraded)
# =====================================================================
#
# This script will:
# 1. Ask for sudo password upfront.
# 2. Run all setup steps in order.
# 3. Show LIVE progress from each sub-script.
#
set -e # Exit immediately if any command fails
# Exporting here is still good practice, but we will be more explicit
export DEBIAN_FRONTEND=noninteractive # Tell apt it's running in a script

# --- Base Directories ---
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_DIR="$BASE_DIR/data"
SCRIPT_DIR="$BASE_DIR/scripts"

# --- Colors ---
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

clear
echo -e "${GREEN}====================================================================="
echo -e " 🚀 Ubuntu Setup Wizard — Live Progress Version"
echo -e "=====================================================================${RESET}\n"

# --- Pre-run Checks ---
echo -e "${YELLOW}Checking file structure...${RESET}"
if [ ! -d "$SCRIPT_DIR" ] || [ ! -d "$DATA_DIR" ]; then
    echo -e "${RED}Error: 'scripts' or 'data' directory not found.${RESET}"
    echo -e "Please ensure your files are in this structure:"
    echo -e "setup.sh"
    echo -e "scripts/"
    echo -e "data/"
    exit 1
fi

# --- Request sudo upfront ---
echo -e "[🔐] Requesting sudo access..."
if sudo -v; then
    echo -e "${GREEN}✅ Sudo access granted.${RESET}"
else
    echo -e "${RED}❌ Failed to get sudo access. Exiting.${RESET}"
    exit 1
fi

# Keep sudo alive
( while true; do sudo -n true; sleep 60; done ) &
KEEP_ALIVE_PID=$!
# Kill the background keep-alive process on script exit
trap 'kill $KEEP_ALIVE_PID' EXIT

# --- Function: run_step ---
# This new version runs the script in the foreground so you
# can see its live progress output.
run_step() {
    local title=$1
    local script_name=$2
    local description=$3
    local logfile="/tmp/${script_name}.log"

    echo -e "\n${BLUE}====================================================================="
    echo -e " 🔵 STARTING: $title"
    echo -e " ${YELLOW}$description${RESET}"
    echo -e "=====================================================================${RESET}"
    
    # Run the script, piping its output (stdout) to the terminal AND a log file.
    # stderr is also captured in the log file.
    if bash "$SCRIPT_DIR/$script_name" 2> >(tee -a "$logfile" >&2) | tee "$logfile"; then
        echo -e "\n${GREEN}✅ FINISHED: $title${RESET}"
    else
        echo -e "\n${RED}⚠️  ERROR: $title failed.${RESET}"
        echo -e "${YELLOW}See log for details: $logfile${RESET}"
        tail -n 10 "$logfile"
        exit 1 # Stop the whole setup
    fi
}

# --- Run All Steps ---
# I've re-ordered these to be more logical (remove before install)
# and added an 'apt update' step.

echo -e "\n${BLUE}====================================================================="
echo -e " 🔵 STARTING: Updating APT Package Lists"
echo -e "=====================================================================${RESET}"
# --- FIX: Added DEBIAN_FRONTEND directly to the sudo command ---
sudo DEBIAN_FRONTEND=noninteractive apt update -y

run_step "Snap Cleanup" "remove_snap.sh" "Removing unwanted Snap packages from ./data/remove_snap.txt"
run_step "APT Cleanup" "remove_apt.sh" "Removing unwanted APT packages from ./data/remove_apt.txt"
run_step "APT Installation" "install_apt.sh" "Installing APT packages from ./data/apt_apps.txt"
run_step "Flatpak Setup" "setup_flatpak.sh" "Setting up Flatpak and adding Flathub repo"
run_step "Flatpak Installation" "install_flatpak.sh" "Installing Flatpak apps from ./data/flatpak_apps.txt"

echo -e "\n${GREEN}====================================================================="
echo -e " 🎉 ALL TASKS COMPLETED SUCCESSFULLY! 🎉"
echo -e "=====================================================================${RESET}"
echo -e "\n${YELLOW}====================================================================="
echo -e " You may need to reboot ofr changes to take effect"
echo -e "=====================================================================${RESET}"

