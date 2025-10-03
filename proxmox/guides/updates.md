# Updating Proxmox VE

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: 9.0-1
- **Audience**: Users with existing Proxmox VE installation
- **Prerequisites**: Working Proxmox VE installation, internet access

---

## 2. Introduction

This guide explains how to update Proxmox VE to the latest version using the **no-subscription repository**, which is recommended for home labs or non-production environments.

> Tip: Always back up your VMs and configuration before updating.

---

## 3. Preparation

Before updating, ensure:

- **Backup**: All VMs, containers, and configuration files  
- **Current Version Check**: Run `pveversion` to know your current Proxmox version  
- **Tools Needed**: Terminal access with sudo privileges  
- **Important Notes / Warnings**: Using the no-subscription repository is suitable for non-production only

---

## 4. Procedure Steps

### 4.1 Switch to the No-Subscription Repository

> By default, Proxmox uses the enterprise repository which requires a subscription.

#### 4.1.1 Remove Enterprise and Ceph Sources

- **Command / Action**:

```bash
sudo rm -f /etc/apt/sources.list.d/pve-enterprise.sources
sudo rm -f /etc/apt/sources.list.d/ceph.sources
```

- **Notes / Warnings**:

> Removing these sources ensures your system will not pull updates from the enterprise repository.

#### 4.1.2 Download the Official GPG Key

- **Command / Action**:

```bash
wget https://enterprise.proxmox.com/debian/proxmox-release-trixie.gpg -O /usr/share/keyrings/proxmox-archive-keyring.gpg
```

- **Notes / Warnings**:

> This key will authenticate packages from the no-subscription repository.

#### 4.1.3 Create No-Subscription Sources

- **Command / Action**:

1. Create the file `/etc/apt/sources.list.d/proxmox-no-subscription.sources` with the following content:

```bash
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
```

- **Notes / Warnings**:

> Replace `trixie` with your current Proxmox/Debian release:

```bash
cat /etc/os-release
```

### 4.2 Update Package Lists

- **Command / Action**:

```bash
sudo apt update
```

- **Notes / Warnings**:

> Your system will now pull packages from the no-subscription repository.

---

## 5. Verification / Testing

- Check available updates:

```bash
apt list --upgradable
```
- Upgrade Proxmox packages:

```bash
sudo apt upgrade
```

- Reboot if required:

```bash
sudo reboot
```

- Verify new version:

```bash
pveversion
```

---
