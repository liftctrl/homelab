# Proxmox Cloud-Init Template Guide

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: Proxmox VE 9.0
- **Audience**: Administrators building reusable VM templates
- **Prerequisites**: Installed Proxmox VE, Internet access to fetch cloud images, admin/root privileges

---

## 2. Introduction

This guide explains how to create a reusable Proxmox VM template using **cloud-init**. This allows automated deployment of VMs with preconfigured users, networking, and SSH keys — ideal for scaling environments or integrating with automation tools like Terraform.  

---

## 3. Preparation

Before starting:  

- Decide on a target OS (e.g., Ubuntu cloud image).  
- Know the VM storage location (e.g., `local`, `local-lvm`).  
- Confirm network bridge (e.g., `vmbr0`).  
- Ensure sufficient CPU, RAM, and disk resources.  

---

## 4. Procedure Steps

### 4.1 Prepare the Cloud Image

- **Download image**:

```bash
wget https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/noble/current/noble-server-cloudimg-amd64.img
```

- Upload via Proxmox Web UI: **Storage** → **Content** → **Upload**

### 4.2 Create Base VM (No Disk)

- Use **Create VM** wizard:
  - **General**: VM ID & Name (e.g., ubuntu-cloud)
  - **OS**: None selected
  - **System**: Defaults (SeaBIOS, i440fx)
  - **Hard Disk**: Remove default disk
  - **CPU/Memory**: Assign resources (e.g., 2 cores, 2 GB RAM)
  - **Network**: Bridge vmbr0, model VirtIO
- Result: VM with no disk or ISO attached

### 4.3 Import Cloud Image as System Disk

- **Import via CLI**:

```bash
qm importdisk <VMID> <cloud-image>.img <storage-name>
```

- Attach imported disk via GUI:
  - VM → **Hardware** → Edit **Unused Disk 0**
  - Set **Bus/Device**: SCSI, **Controller**: VirtIO SCSI

### 4.4 Remove CD/DVD Drive

- VM → **Hardware** → remove `ide2` CD-ROM

> Prevents clones from accidentally booting into installer.

### 4.5 Add Cloud-Init Disk

- VM → **Hardware** → **Add** → **Cloud-Init Disk**
- Bus: IDE2

### 4.6 Set Boot Order

- VM → **Options** → **Boot Order**
- Ensure **SCSI0** is first, remove CD-ROM

### 4.7 (Optional) Configure Serial Console

```bash
qm set <VMID> --serial0 socket --vga serial0
```

> Useful for debugging or headless environments.

### 4.8 Apply Cloud-Init and Configure

- VM → **Cloud-Init tab**:
  - Username/password
  - SSH key(s)
  - Network (static IP or DHCP)
- Click **Regenerate Cloud-Init Configuration**
- Boot VM and verify

### 4.9 Install & Enable QEMU Guest Agent

```bash
sudo apt update
sudo apt install -y qemu-guest-agent
systemctl enable --now qemu-guest-agent
systemctl status qemu-guest-agent
```

> Enables IP reporting, graceful shutdowns, and automation support.

### 4.10 Convert to Template

- Remove and re-add a new Cloud-Init disk (to reset config).
- Convert VM to **Template**.

### 4.11 Create VM from Template

- Right-click template → **Clone**
- Configure hostname, SSH keys, user credentials, networking
- Click **Regenerate Cloud-Init Configuration**
- Boot VM → settings apply automatically

---

## 5. Verification / Testing

- Clone VM → boot it → ensure:
  - SSH works with injected key/password.
  - Network config matches cloud-init settings.
  - QEMU guest agent reports IP in Proxmox GUI.

---
