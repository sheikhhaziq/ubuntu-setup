#!/bin/bash
# Installs Flatpak and adds the Flathub remote.
set -e

echo "Installing Flatpak and GNOME plugin..."
sudo apt install -y flatpak gnome-software-plugin-flatpak > /dev/null

echo "Adding Flathub repository..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Updating Flatpak..."
sudo flatpak update -y

echo "Flatpak setup complete."
