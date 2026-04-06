# Personal sing-box Workspace

A streamlined configuration suite for **Android** and **Windows**, optimized for the **[reF1nd fork](https://github.com/reF1nd/sing-box)** (required for `proxy_providers`).

---

## 📂 File Reference

| File | Platform | Usage / Notes |
| :--- | :--- | :--- |
| **`config_wins.json`** | Windows | Main config. **Must rename to `config.json`** for the script. |
| **`config_box.json`** | Android (Box) | For Magisk modules (Box4Magisk, KM-Box, etc.). |
| **`config_sfa.json`** | Android (SFA) | Dedicated config for the **Sing-box for Android** app. |
| **`webRTC.json`** | General | Rule-set for optimizing or blocking WebRTC/STUN traffic. |
| **`singbox-manager.ps1`** | Windows | Management script (requires `sing-box.exe` & `config.json`). |
| **`start-manager.bat`** | Windows | Portable launcher. Edit `TARGET_DIR` inside to use. |

---

## 🚀 Quick Start

### Windows
1. **Prepare**: Place `sing-box.exe`, `config.json` (renamed from `config_wins.json`), and `singbox-manager.ps1` in the same folder.
2. **Configure**: Edit `start-manager.bat` and set `TARGET_DIR` to your actual folder path.
3. **Run**: Double-click `start-manager.bat` from any directory to launch the manager.

### Android (Box Modules)
1. **Deploy**: Upload `config_box.json` (rename to `config.json`) and `webRTC.json` to your module's config directory.
2. **Core**: Ensure the module is using the **reF1nd fork** binary (chmod `0755`).

### Android (SFA App)
1. **Import**: Open the **Sing-box for Android** app and import `config_sfa.json`.
2. **Note**: Ensure the app version supports the features defined in the profile.

---

## 🛠 Features
* **Smart Routing**: Pre-configured rules for Google, Telegram, YouTube, and Ad-blocking.
* **Cyberpunk UI**: Enhanced Windows management via PowerShell with live monitoring.
* **High Performance**: Optimized DNS over QUIC/HTTP3 and memory management.

---
*Disclaimer: For personal use and technical research only.*
