# VM Deployment with Terraform

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02  
- **Version**: Terraform Provider bpg/proxmox `0.84.1` + Proxmox VE 9.0  
- **Audience**: DevOps engineers, automation admins  
- **Prerequisites**:  
  - Proxmox cluster running  
  - Cloud-Init template prepared (`templates.md`)  
  - Provider configured (`provider.md`)  
  - SSH keys generated (`ssh-keys.md`)  

---

## 2. Introduction

This guide demonstrates how to deploy VMs in Proxmox using Terraform.  
It covers cloning from a Cloud-Init template, configuring CPU, memory, disks, networks, enabling QEMU Guest Agent, and injecting SSH keys for automated access.  

---

## 3. Preparation

- Ensure you have an API token with sufficient permissions (`access.md`).  
- A Cloud-Init template must exist in Proxmox (`templates.md`).  
- Terraform workspace is initialized and provider verified (`provider.md`).  

---

## 4. Procedure Steps

### 4.1 Basic VM Resource

```tf
resource "proxmox_virtual_environment_vm" "cloudinit_vm" {
  node_name   = "pve"
  name        = "cloudinit-test"
  on_boot     = true
}
```

- `node_name`: Proxmox node name.
- `name`: VM name.
- `on_boot`: Auto-start on host boot.

### 4.2 Clone a Cloud-Init Template

```tf
clone {
  vm_id = 101
  full  = true
}
```

- `vm_id`: ID of base Cloud-Init template.
- `full = true`: Full clone (independent VM).

### 4.3 CPU and Memory

```tf
cpu {
  sockets = 2
  cores   = 1
  type    = "qemu64"
}

memory {
  dedicated = 2048
}
```

- `sockets/cores`: vCPU allocation.
- `type`: CPU type.
- `dedicated`: RAM in MB.

### 4.4 Disk Configuration

```tf
disk {
  size         = 40
  interface    = "scsi0"
  datastore_id = "local-lvm"
}
```

- `size`: Disk size (GB).
- `interface`: Recommended scsi0.
- `datastore_id`: Storage pool.

### 4.5 Network Configuration

```tf
network_device {
  model   = "virtio"
  bridge  = "vmbr0"
  enabled = true
}
```

- `model`: NIC type (`virtio`).
- `bridge`: Proxmox bridge (`vmbr0`).
- `enabled`: Enable NIC.

### 4.6 Enable QEMU Guest Agent

```tf
agent {
  enabled = true
  type    = "virtio"
  timeout = "15m"
}
```

- Enables Guest Agent for IP reporting, shutdown, and integration.

### 4.7 Cloud-Init Configuration

```tf
initialization {
  datastore_id = "local-lvm"

  ip_config {
    ipv4 {
      address = "192.168.0.200/24"
      gateway = "192.168.0.1"
    }
  }

  user_account {
    username = "test"
    keys     = [trimspace(data.local_file.ssh_public_key.content)]
  }
}
```

- `datastore_id`: Cloud-Init datastore.
- `ip_config`: Static IPv4 and gateway.
- `user_account`: User + SSH public key injection.

---

## 5. Verification / Testing

- Run:

```bash
terraform apply
```

- Verify VM is created and powered on in Proxmox.
- SSH into the VM using:

```bash
ssh -i proxmox_test test@192.168.0.200
```

- Confirm guest agent reports IP:

```bash
qm guest cmd <VMID> network-get-interfaces
```

---
