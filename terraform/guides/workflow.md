# Terraform Workflow: Plan, Apply, and Validate

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-03  
- **Version**: Terraform `1.x` + Proxmox Provider `bpg/proxmox 0.84.1`  
- **Audience**: DevOps, SRE, automation engineers  
- **Prerequisites**:  
  - Proxmox provider configured (`provider.md`)  
  - VM resources defined (`virtual-machines.md`)  
  - SSH key prepared (`ssh-keys.md`)  

---

## 2. Introduction

This guide explains the typical Terraform workflow when managing Proxmox resources.  
You’ll learn how to preview (`plan`), deploy (`apply`), verify resources, and update or remove them safely.  

---

## 3. Preparation

- Terraform installed and initialized (`terraform init`).  
- A valid `main.tf` with VM definitions.  
- API token with sufficient permissions (`accounts.md` / `access.md`).  
- SSH key available for login (`ssh-keys.md`).  

---

## 4. Procedure Steps

### 4.1 Plan Deployment

Preview changes before applying:  

```bash
terraform plan
```

### 4.2 Apply Deployment

Apply changes to create/update VMs:

```bash
terraform apply
```

- Terraform prompts for confirmation → type **yes**.
- Creates or updates VMs as defined in `main.tf`.

### 4.3 Validate Deployment

After deployment:

1. **Check Proxmox Web UI**
   - Confirm VM appears in correct node.
   - Verify CPU, memory, disk, network.
2. **SSH into VM**

```bash
ssh -i proxmox_test test@192.168.0.200
```

- `-i proxmox_test`: Private key path.
- `test`: Username from Cloud-Init.
- `192.168.0.200`: IP assigned in Terraform config.

3. **Verify Configuration**

- Static IP applied.
- SSH key injected correctly.
- Services running as expected.

### 4.4 Update Resources

When modifying `main.tf` (e.g., increase CPU, add disk):

```bash
terraform plan
terraform apply
```

Terraform updates only the changed resources.

### 4.5 Destroy Resources

Remove all managed resources:

```bash
terraform destroy
```

- Prompts for confirmation.
- Safely deletes VMs and associated resources.

---
