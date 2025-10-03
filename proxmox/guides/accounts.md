# Users and API Tokens in Proxmox VE

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: Proxmox VE 9.0
- **Audience**: Administrators managing user accounts and automation access
- **Prerequisites**: Installed Proxmox VE, Datacenter admin access (GUI or CLI)

---

## 2. Introduction

This guide explains how to create users in Proxmox VE and generate API tokens for automation workflows. API tokens provide secure, revocable credentials for tools like Terraform or Ansible.

> **Security Note**: Always follow the principle of least privilege. Assign only the roles required for automation tasks.

---

## 3. Preparation

Before creating accounts:  

- Decide whether the account will be **human** (interactive login) or **automation** (API/token only).  
- Ensure your Proxmox node or cluster is accessible via Web UI or CLI.  
- Plan a clear naming convention (e.g., `terraform@pve`).  

---

## 4. Procedure Steps

### 4.1 Create a User

#### 4.1.1 Using the GUI

1. Navigate to: **Datacenter → Permissions → Users → Add → User**  
2. Fill in required fields:  
   - **User ID**: e.g., `terraform@pve`  
   - Realm: `pve`  
   - Optional: Expiry, Groups  
3. Click **Add**  

#### 4.1.2 Using the CLI

```bash
pveum user add automation@pve
```

> Use descriptive usernames to clearly identify automation accounts.

### 4.2 Generate an API Token

#### 4.2.1 Using the GUI

1. Navigate to: **Datacenter** → **Permissions** → **API Tokens** → **Add** → **API Token**
2. Fill in:
   - **User ID**: e.g., terraform@pve
   - **Token ID**: e.g., terraform-token
   - **Privilege Separation**: Enable if the token should have distinct permissions
3. Click **Add**
4. Save the **secret** immediately — it is displayed only once

#### 4.2.2 Using the CLI

```bash
# Create token
pveum user token add terraform@pve terraform-token --comment "API token for terraform"

# List user tokens
pveum user token list terraform@pve
```

### 4.3 Test the API Token

- Verify the token works with a simple API call:

```bash
curl -k -H 'Authorization: PVEAPIToken=terraform@pve!terraform-token=<secret>' \
  https://192.168.0.100:8006/api2/json/version
```

- Expected output: Proxmox version JSON response

---

## 5. Verification / Testing

- Confirm user appears in **Datacenter** → **Permissions** → **Users**
- Confirm token is listed under **API Tokens**
- Test with `curl` or via automation tool (e.g., Terraform provider)
- Revoke token if needed:

```bash
pveum user token delete terraform@pve terraform-token
```

---
