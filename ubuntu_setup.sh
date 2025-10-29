#!/bin/bash
# =====================================================================
# 🚀 Ubuntu Setup Bootstrap Script
#
# This script is intended to be run from a fresh system:
# curl -sSL "https://raw.githubusercontent.com/sheikhhaziq/ubuntu-setup/main/ubuntu_setup.sh" | bash
# =====================================================================

set -e

# --- Repository Configuration ---
GITHUB_USER="sheikhhaziq"
REPO_NAME="ubuntu-setup"
# --- End Configuration ---

# --- Colors ---
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

# --- Variables ---
REPO_URL="https://github.com/$GITHUB_USER/$REPO_NAME.git"
LOCAL_DIR="$HOME/$REPO_NAME"

# --- Header ---
clear
echo -e "${GREEN}====================================================================="
echo -e " 🚀 Starting Ubuntu Setup for '$REPO_NAME'"
echo -e "=====================================================================${RESET}\n"

# --- Request sudo upfront ---
echo -e "[🔐] Requesting sudo access for installing Git..."
if sudo -v; then
    echo -e "${GREEN}✅ Sudo access granted.${RESET}"
else
    echo -e "${RED}❌ Failed to get sudo access. Exiting.${RESET}"
    exit 1
fi
# Keep sudo alive
( while true; do sudo -n true; sleep 60; done ) & KEEP_ALIVE_PID=$!
trap 'kill $KEEP_ALIVE_PID' EXIT

# --- Step 1: Install Git ---
echo -e "\n${BLUE}==> 1. Installing Git...${RESET}"
# Use DEBIAN_FRONTEND=noninteractive to suppress apt warnings
sudo DEBIAN_FRONTEND=noninteractive apt update -y > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt install git -y
echo -e "${GREEN}✅ Git is installed.${RESET}"

# --- Step 2: Clone Repository ---
echo -e "\n${BLUE}==> 2. Cloning repository...${RESET}"
if [ -d "$LOCAL_DIR" ]; then
    echo -e "${YELLOW}Warning: Directory '$LOCAL_DIR' already exists.${RESET}"
    echo -e "Skipping clone. Will attempt to run setup from existing directory."
else
    git clone "$REPO_URL" "$LOCAL_DIR"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Failed to clone repository. Exiting.${RESET}"
        exit 1
    fi
    echo -e "${GREEN}✅ Repo cloned to $LOCAL_DIR${RESET}"
fi

# --- Step 3: Change Directory and Set Permissions ---
echo -e "\n${BLUE}==> 3. Setting permissions...${RESET}"
cd "$LOCAL_DIR"
if [ ! -f "setup.sh" ]; then
    echo -e "${RED}Error: 'setup.sh' not found in repository. Exiting.${RESET}"
    exit 1
fi
chmod +x setup.sh scripts/*.sh
echo -e "${GREEN}✅ Scripts are now executable.${RESET}"

# --- Step 4: Run Main Setup Script ---
echo -e "\n${BLUE}==> 4. Handing off to main setup script...${RESET}"
echo -e "---------------------------------------------------------------------"
# Run the main setup script
./setup.sh
echo -e "---------------------------------------------------------------------"

# --- All Done ---
echo -e "\n${GREEN}🎉 All done! Main setup script has finished.${RESET}"
echo -e "You can find your setup files in: $LOCAL_DIR"
