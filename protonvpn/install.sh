#!/bin/bash
# install_protonvpn.sh - Install ProtonVPN (Debian/Ubuntu)

set -e

echo -e "\n\033[1;34m[1/5] Downloading ProtonVPN repository package...\033[0m"
wget -q https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb

# echo -e "\n\033[1;34m[2/5] Verifying package checksum...\033[0m"
# echo "0b14e71586b22e498eb20926c48c7b434b751149b1f2af9902ef1cfe6b03e180 protonvpn-stable-release_1.0.8_all.deb" | sha256sum --check -

echo -e "\n\033[1;34m[3/5] Installing repository and updating...\033[0m"
sudo dpkg -i ./protonvpn-stable-release_1.0.8_all.deb >/dev/null
sudo apt update -y >/dev/null

echo -e "\n\033[1;34m[4/5] Installing ProtonVPN desktop and dependencies...\033[0m"
sudo apt install -y proton-vpn-gnome-desktop libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator >/dev/null

echo -e "\n\033[1;32m[✓] ProtonVPN installed successfully!\033[0m"
rm -f protonvpn-stable-release_1.0.8_all.deb
