# 🧰 Ubuntu Setup Automation

This repository provides a **complete automated setup script** for Ubuntu (GNOME) — ideal for quickly provisioning new systems with your preferred apps, Flatpaks, and system configurations.

---

## 🚀 Features

- 🧩 **Automatic apt package installation** from `apt-packages.txt`
- 📦 **Flatpak setup & Flathub repo configuration**
- 🧼 **Removal of unwanted apt & snap apps**
- 💡 **Flatpak app installation** from `flatpak-apps.txt`
- ⚙️ **Single sudo prompt** (no repeated password requests)
- 🪟 **Interactive, intuitive shell UI**

---

## 🗂️ Project Structure

```
ubuntu-setup/
├──data/
├  ├── apt_apps.txt             # List of apt packages to install
├  ├── flatpak-apps.txt         # List of Flatpak apps to install
├  ├── remove_apt_apps.txt      # List of apt apps to remove
├  ├── remove_snap_apps.txt     # List of snap apps to remove
├──scripts/
├  ├── remove_snap_apps.sh      # Removes unwanted Snap packages
├  ├── remove_apt_apps.sh       # Removes unwanted apt packages  
├  ├── install_apt_apps.sh      # Installs apt packages listed in apt-packages.txt
├  ├── flatpak_setup.sh         # Sets up Flatpak and Flathub
├  ├── install_flatpak_aps.sh   # Installs Flatpak apps from flatpak-apps.txt
├── 
├── setup.sh                    # Main orchestrator script
├── ubuntu_setup.sh             # Quick installation script        
└── README.md                   # Documentation
```

---

## ⚙️ Usage
### 🏃 Quick Install (recommended)

Run this single command — it will clone and execute everything automatically:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/sheikhhaziq/ubuntu-setup/main/ubuntu_setup.sh)
```


You’ll be prompted once for your password.
After that, the script runs non-interactively.

This will sequentially execute:
1. apt app cleanup
2. snap cleanup
3. apt package installation
4. Flatpak setup
5. Flatpak app installation

---

## 🧱 Example Workflow

```bash
# Clone repository
git clone https://github.com/sheikhhaziq/ubuntu-setup.git
cd ubuntu-setup

# Make scripts executable
chmod +x *.sh

# Run main script
sudo ./setup.sh
```

---

## 🧩 Customization

- Modify `data/apt_apps.txt` or `data/flatpak_apps.txt` to fit your preferences.  
- Add or remove unwanted applications in `data/remove_apt_apps.sh` and `data/remove_snap_apps.sh`.  
- You can also integrate your own scripts inside `setup.sh` to extend functionality.

---

## 🧑‍💻 Author

**Sheikh Haziq**  
🚀 [GitHub](https://github.com/sheikhhaziq)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

> 💡 Designed for Ubuntu GNOME users who want a one-command setup experience.