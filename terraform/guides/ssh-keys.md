# SSH Key Preparation for Terraform Proxmox VMs

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: Proxmox VE 9.0 / Terraform integration
- **Audience**: Administrators preparing SSH keys for VM provisioning
- **Prerequisites**: Linux/macOS/WSL with `ssh-keygen` installed, Terraform configured with Proxmox provider

---

## 2. Introduction

This guide explains how to generate, manage, and use SSH keys for Terraform-provisioned Proxmox VMs. Public keys are injected into VMs during provisioning, allowing secure, passwordless access.  

> **Security Note**: Private keys must be kept secure and never committed to version control.  

---

## 3. Preparation

Before starting:  

- Ensure you have a working Terraform + Proxmox setup.  
- Decide where to store your key pair (safe local directory, or secure vault).  
- If you already have an SSH key pair, you may reuse it.  

---

## 4. Procedure Steps

### 4.1 Generate SSH Keys

- **Command**:

```bash
ssh-keygen -t rsa -b 4096 -f proxmox_test
```

- **Result**:
  - `proxmox_test` → Private key (keep secure).
  - `proxmox_test.pub` → Public key (used in Terraform).

### 4.2 Reference the SSH Key in Terraform

- Use Terraform’s `local_file` data source to read the public key:

```tf
data "local_file" "ssh_public_key" {
  filename = "./proxmox_test.pub"
}
```

- Example usage in a VM definition:

```tf
user_account {
  username = "test"
  keys     = [trimspace(data.local_file.ssh_public_key.content)]
}
```

- **Fields**:
  - `username`: User created inside the VM.
  - `keys`: Injected public key for SSH login.

### 4.3 Use the Private Key to Access the VM

- **Command**:

```bash
ssh -i proxmox_test test@192.168.0.200
```

- **Parameters**:
  - `-i proxmox_test`: Path to private key.
  - `test`: Username created via Cloud-Init.
  - `192.168.0.200`: VM IP address (static/DHCP).

### 4.4 Best Practices

- Never commit private keys to version control.
- Use a passphrase to protect private keys:

```bash
ssh-keygen -p -f proxmox_test
```

- Store keys in a secure vault (e.g., `~/.ssh`, HashiCorp Vault, 1Password).
- Reuse the same key across multiple VMs for simplicity, or generate per-project keys for stricter security.

---

## 5. Verification / Testing

- Confirm that Terraform injects the public key into the VM.
- Attempt SSH login using the private key.
- Run:

```bash
ssh -i proxmox_test test@192.168.0.200 "hostname"
```

to verify connectivity and authentication.

---
