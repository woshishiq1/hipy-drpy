# Personal sing-box Workspace

---
## 📋 Prerequisites

### The Core (Mandatory)
A streamlined config set for **Android** and **Windows**, optimized for the **[reF1nd fork](https://github.com/reF1nd/sing-box)** (required for `proxy_providers`).

---

## 📂 Quick Setup Reference

| Platform | Config File | Target Directory | Management Tool |
| :--- | :--- | :--- | :--- |
| **Windows** | `config_wins.json` | Same folder as `sing-box.exe` | `start-manager.bat` |
| **Android** | `config_box.json` | `/data/adb/box/` | Box4Magisk / Box |

---

## 🚀 Windows Guide

1.  **Preparation**: Rename `config_wins.json` to `config.json` and ensure your core is named `sing-box.exe`.
2.  **Configure**: Edit `start-manager.bat` and set `TARGET_DIR` to your actual folder path.
3.  **Run**: Place `start-manager.bat` anywhere and double-click to launch the manager.

## 📱 Android Guide

1.  **Config**: Upload `config_box.json` to your module's config folder (rename to `config.json`).
2.  **Core**: Replace the module's default binary with the **reF1nd fork** (chmod `0755`).

---

## 🛠 Key Features
* **Smart Routing**: Pre-configured for Google, Telegram, YouTube, and Ad-blocking.
* **Service-Based**: Run as a Windows Service for silent background operation.
* **DNS over QUIC**: High-speed, secure DNS resolution.

*Disclaimer: For personal use and technical research only.*
