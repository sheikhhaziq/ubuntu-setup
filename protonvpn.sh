#!/bin/bash
# protonvpn.sh - Control script for installing/uninstalling ProtonVPN

# Ask for sudo password once and keep alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

clear
echo -e "\033[1;36m=========================================\033[0m"
echo -e "\033[1;32m         ProtonVPN Setup Script          \033[0m"
echo -e "\033[1;36m=========================================\033[0m"
echo ""
echo "Choose an option:"
echo "  1) Install ProtonVPN"
echo "  2) Uninstall ProtonVPN"
echo "  3) Exit"
echo ""
read -p "Enter choice [1-3]: " choice

case $choice in
    1)
        bash ./protonvpn/install.sh
        ;;
    2)
        bash ./protonvpn/uninstall.sh
        ;;
    3)
        echo -e "\n\033[1;33mExiting...\033[0m"
        exit 0
        ;;
    *)
        echo -e "\n\033[1;31mInvalid choice!\033[0m"
        exit 1
        ;;
esac
