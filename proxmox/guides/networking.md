# Network Configuration in Proxmox VE

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: Proxmox VE 9.0
- **Audience**: Administrators configuring Proxmox VE networking
- **Prerequisites**: Installed Proxmox VE system, root/admin access

---

## 2. Introduction

This guide explains how to configure networking in Proxmox VE, focusing on the default bridge mode setup (single NIC) that connects both the host and virtual machines to the same LAN subnet.

> Tip: Always back up your `/etc/network/interfaces` file before making changes.

---

## 3. Preparation

Before configuring networking, ensure:  

- You have identified the correct network interface name (`eno1`, `eth0`, etc.).  
- You know your LAN details (IP address, gateway, DNS).  
- You can access the Proxmox GUI or CLI.  

---

## 4. Procedure Steps

### 4.1 View Current Network Interfaces

- **Command / Action**:

```bash
ip a
```

or 

```bash
ifconfig -a
```

- **Notes / Warnings**:

> Use this to identify which NICs are available for bridging.

### 4.2 Configure Default Bridge Mode (Single NIC)

**Goal**: Connect the Proxmox host and VMs to the same LAN subnet.

**Example IPs**:

- Host: `192.168.0.100`
- VM: `192.168.0.150`

#### 4.2.1 Configure via CLI (`/etc/network/interfaces`)

- **Command / Action**: Edit `/etc/network/interfaces`

```bash
auto lo
iface lo inet loopback

auto vmbr0
iface vmbr0 inet static
    address 192.168.0.100/24
    gateway 192.168.0.1
    bridge_ports eno1
    bridge_stp off
    bridge_fd 0
    dns-nameservers 1.1.1.1
```

- **Notes / Warnings**:

> Replace `eno1` with the correct interface name identified earlier.
> Mistakes can lock you out — consider testing via console instead of SSH.

#### 4.2.2 Configure via GUI

- Navigate to: **Datacenter** → **Node** → **Network** → **Create** → **Linux Bridge**
- Set the bridge name to `vmbr0` and attach it to the correct NIC.
- Apply changes and reboot or reload networking if required.

#### 4.2.3 Network Diagram

```text
[LAN Router]
     |
   eno1
     |
  vmbr0 (Host + VM)
     |
    VM
```

> In this setup, both the host and virtual machines share the same LAN connection.

---

## 5. Verification / Testing

- Check bridge status:

```bash
brctl show
```

- Verify host connectivity:

```bash
ping 1.1.1.1
```

- Start a VM and confirm it receives an IP and can access the LAN/internet.

---
