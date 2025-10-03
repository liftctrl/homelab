# Proxmox VE Guide

## 1. Overview

This guide explains how to install and configure **Proxmox VE** on a target server.  
It includes environment details, credentials, installation steps, configuration, and how to access the web interface.  

---

## 2. Environment

- **Hostname (FQDN):** pve.homelab.com  
- **Country / Time Zone:** Taiwan / Asia/Taipei  
- **Keyboard Layout:** U.S. English  
- **Management Interface:** eno1  
- **IP Address (CIDR):** 192.168.0.100/24  
- **Gateway:** 192.168.0.1  
- **DNS:** 1.1.1.1  

**Prerequisites:**  

- Proxmox VE ISO written to bootable USB  
- Target server supports USB boot  
- Network prepared with static IP  

---

## 3. Credentials

- **Username:** root  
- **Password:** ******  

> ⚠️ Change this password immediately after installation for security.  

---

## 4. Installation

1. Insert the Proxmox bootable USB into the target server  
2. Enter BIOS/UEFI → set USB as boot device  
3. From the boot menu, select **Install Proxmox VE**  
4. Follow installer prompts:  
   - Select installation disk  
   - Configure Country / Time Zone / Keyboard  
   - Set root password and optional email  
5. Configure network:  
   - Interface: `eno1`  
   - Hostname (FQDN): `pve.homelab.com`  
   - IP: `192.168.0.100/24`  
   - Gateway: `192.168.0.1`  
   - DNS: `1.1.1.1`  
6. Confirm and start installation  
7. Remove USB and reboot  

---

## 5. Configuration

- Ensure the system boots into Proxmox VE  
- Verify network connectivity  
- Check web service availability  

---

## 6. Access

- **Web UI:** https://192.168.0.100:8006

- **Login:** root / ******  

---

## 7. Management

- Create and manage virtual machines or containers  
- Perform backups and restores  
- Update system via CLI or web interface  
- Troubleshoot issues using logs and console  

---

## 8. Appendix

- **FQDN:** Fully Qualified Domain Name  
- **Reference:** [Proxmox Official Documentation](https://www.proxmox.com/en/proxmox-ve)

---
