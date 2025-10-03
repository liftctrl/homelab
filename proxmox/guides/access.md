# Permissions in Proxmox VE

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: Proxmox VE 9.0
- **Audience**: Administrators managing users and API tokens in Proxmox
- **Prerequisites**: Existing Proxmox VE installation, admin access (GUI/CLI)

---

## 2. Introduction

This guide explains how to assign permissions in Proxmox VE for existing users and API tokens. It covers both the GUI and CLI methods, as well as key points regarding token inheritance.

> Tip: Always apply the **principle of least privilege** to minimize security risks.

---

## 3. Preparation

Before assigning permissions, ensure:  

- You have admin-level access to Proxmox VE (via Web GUI or root shell).  
- The user already exists in Proxmox (`pveum useradd` or GUI-created).  
- You understand the role requirements (built-in roles vs. custom roles).  

---

## 4. Procedure Steps

### 4.1 Assign Permissions to Existing Users

#### 4.1.1 Using the GUI

1. Navigate to: **Datacenter** → **Permissions** → **Add** → **User Permission**  
2. Select the existing user (e.g., `terraform@pve`).  
3. Set **Path**: `/` (full access) or `/vms` (restricted to VM management).  
4. Assign **Role**: `Administrator` or a custom role for limited access.  
5. Click **Add**.  

#### 4.1.2 Using the CLI with a Custom Role

1. Create a custom role with specific privileges:

```bash
pveum roleadd AutomationRole \
  -privs "VM.Allocate VM.Audit VM.Console VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit Pool.Audit"
```

2. Assign the role to the user:

```bash
pveum aclmod / -user terraform@pve -role AutomationRole
```

> This ensures the user only has privileges needed for automation or VM management.

### 4.2 Assign Permissions for API Tokens

- API tokens **inherit all permissions** from their parent user.
- Steps:
  1. Confirm the parent user (e.g., `terraform@pve`) has correct permissions.
  2. Navigate to: **Datacenter** → **Permissions** → **API Tokens**.
  3. Verify the token (e.g., `terraform-token`) is assigned to the correct user.
  4. Adjust the parent user’s role or path to restrict or expand token access.

> Key point: API tokens **cannot have separate permissions** — managing the parent user’s privileges controls the token’s capabilities.

---

## 5. Verification / Testing

- Check assigned permissions in the GUI: **Datacenter** → **Permissions**
- Test user login with the GUI or API:

```bash
pvesh get /access/permissions -user terraform@pve
```

- Attempt restricted actions to confirm least privilege is enforced.

---
