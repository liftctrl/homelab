# Installing Proxmox VE

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: 9.0-1
- **Audience**: Beginners or users with basic Linux knowledge
- **Prerequisites**: USB drive, computer with internet access

---

## 2. Introduction

This guide helps users install Proxmox VE, create a bootable USB drive, and verify that it works.

> Tip: Follow each step carefully to avoid mistakes that could overwrite important data.

---

## 3. Preparation

Before starting the installation, ensure you have the following:

- **Hardware Requirements**: USB drive (at least 4GB)
- **Software Requirements**: Downloaded Proxmox VE ISO
- **Tools Needed**: Terminal access, internet connection
- **Important Notes / Warnings**: Double-check the USB device to prevent data loss.

---

## 4. Procedure Steps

### 4.1 Prepare USB Drive

- **Command / Action**:

```bash
lsblk
```

- **Notes / Warnings**:

> Make sure to identify the correct USB device to avoid overwriting other drives.

### 4.2 Download Proxmox VE ISO

- **Command / Action**:

```bash
wget https://enterprise.proxmox.com/iso/proxmox-ve_9.0-1.iso
```

```bash
sha256sum proxmox-ve_9.0-1.iso
```

- **Notes / Warnings**:

> Verify checksum to ensure the ISO file is not corrupted or tampered with.

### 4.3 Write ISO to USB

- **Command / Action**:

```bash
sudo dd if=proxmox-ve_9.0-1.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

- **Notes / Warnings**:

> Replace `/dev/sdX` with your USB device. This operation will completely overwrite the USB drive.

### 4.4 Verify and Eject USB

- **Command / Action**:

```bash
sudo eject /dev/sdX
```

- **Notes / Warnings**:

> Optionally, boot a test machine to confirm that the USB works correctly.

---

## 5. Verification / Testing

- Boot a test machine from the USB drive to ensure Proxmox VE starts successfully.
- Troubleshooting tips:
  - If USB is not recognized → check BIOS/UEFI boot order.
  - If Proxmox VE does not start → verify the ISO checksum and recreate the USB.

---
