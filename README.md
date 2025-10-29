# 🌿 My Ubuntu Setup

A personal collection of scripts to automate the setup and configuration of a fresh Ubuntu desktop.

This project removes unwanted `apt` and `snap` packages, installs essential tools, and sets up a customized list of `flatpak` applications.

## 🚀 Quick Install (Recommended)

This method uses the `ubuntu_setup.sh` bootstrap script in this repository to automate the entire process.

On a fresh Ubuntu system, run this single command. This fetches the script directly from this repository and runs it.

> If curl is not installed, install it by running
>
> `sudo apt install curl`
> 
> then proceed

```sh
curl -sSL "https://raw.githubusercontent.com/sheikhhaziq/ubuntu-setup/main/ubuntu_setup.sh" | bash
```

This single command will:

- Ask for your password.

- Install git.

- Clone this repository.

- Run the main setup.sh script.

## ⚙️ Manual Installation

If you prefer to clone the repository and inspect the scripts first, you can follow these steps.

### 1. Install Git

```sh
sudo apt update
sudo apt install git -y
```

### 2. Clone This Repository

```sh
git clone [https://github.com/sheikhhaziq/ubuntu-setup.git](https://github.com/sheikhhaziq/ubuntu-setup.git)
cd ubuntu-setup
```

### 3. Make Scripts Executable

```sh
chmod +x setup.sh scripts/*.sh
```

### 4. Run the Setup
```sh
./setup.sh
```

## ✏️ How to Customize

This setup is fully modular. To change which applications are installed or removed, you only need to edit the .txt files in the data/ directory.

- `data/apt_apps.txt`: List of `apt` packages to install.

- `data/flatpak_apps.txt`: List of `flatpak` app IDs to install.

- `data/remove_apt.txt`: List of `apt` packages to remove.

- `data/remove_snap.txt`: List of `snap` packages to remove.

You can use `#` for comments in these files to keep them organized.