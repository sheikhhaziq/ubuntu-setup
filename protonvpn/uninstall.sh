#!/bin/bash
# uninstall_protonvpn.sh - Uninstall ProtonVPN completely

set -e

echo -e "\n\033[1;33m[1/3] Removing ProtonVPN desktop...\033[0m"
sudo apt autoremove -y proton-vpn-gnome-desktop >/dev/null

echo -e "\n\033[1;33m[2/3] Purging ProtonVPN repository package...\033[0m"
sudo apt purge -y protonvpn-stable-release >/dev/null

echo -e "\n\033[1;33m[3/3] Cleaning up...\033[0m"
sudo apt autoremove -y >/dev/null
sudo apt clean >/dev/null

echo -e "\n\033[1;32m[✓] ProtonVPN uninstalled successfully!\033[0m"
