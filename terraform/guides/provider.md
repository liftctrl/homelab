# Proxmox Provider Setup for Terraform

## 1. Document Metadata

- **Author**: liftctrl
- **Date**: 2025-10-02
- **Version**: Proxmox VE 9.0 / Terraform Provider v0.84.1
- **Audience**: Infrastructure engineers using Terraform with Proxmox
- **Prerequisites**: Installed Proxmox VE cluster, valid API token, Terraform installed locally

---

## 2. Introduction

This guide explains how to set up the **Terraform Proxmox provider** to automate VM and resource management. It covers declaring the provider, configuring authentication, applying security best practices, and troubleshooting common issues.  

> Tip: Always lock provider versions to ensure consistent deployments.

---

## 3. Preparation

Before configuring the provider:  

- Ensure you have an API token (`user@realm!token-id=secret`) created in Proxmox.  
- Confirm Proxmox API is reachable (default: `https://<host>:8006/api2/json`).  
- Install Terraform v1.0+ on your workstation or CI/CD system.  

---

## 4. Procedure Steps

### 4.1 Declare Terraform Block

At the top of `main.tf`, specify the required provider and version:

```tf
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}
```

- **source**: Provider registry (`bpg/proxmox`).
- **version**: Locks provider version for stability.

### 4.2 Configure Proxmox Provider

Add the provider block with connection details:

```tf
provider "proxmox" {
  endpoint  = "https://192.168.0.100:8006/api2/json"
  api_token = "terraform@pve!terraform-token=YOUR-TOKEN-HERE"
  insecure  = true
}
```

- **endpoint**: URL of your Proxmox API.
- **api_token**: API token in `user@realm!token-id=secret` format.
- **insecure**: `true` for self-signed certs, `false` for trusted certs.

### 4.3 Security Best Practices

Avoid hardcoding tokens in configuration files. Use one of the following methods:

**a) Environment Variable**

```bash
export PM_API_TOKEN="terraform@pve!terraform-token=XXXX"
```

```tf
provider "proxmox" {
  endpoint  = "https://192.168.0.100:8006/api2/json"
  api_token = var.pm_api_token
  insecure  = true
}
```

**b) Terraform Variable**

`variables.tf`:

```tf
variable "api_token" {
  type      = string
  sensitive = true
}
```

`terraform.tfvars`:

```tf
api_token = "terraform@pve!terraform-token=XXXX"
```

### 4.4 Verify Provider Connection

Run:

```bash
terraform init
terraform plan
```

- `terraform init`: Downloads the provider plugin.
- `terraform plan`: Validates provider connection and permissions.

---

## 5. Verification / Testing

- Confirm Terraform can authenticate and read Proxmox resources.
- Try a simple resource block (e.g., data source for node list).
- Ensure provider version matches `required_providers` in `main.tf`.

---
