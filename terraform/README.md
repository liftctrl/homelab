# Terraform Guide

## 1. Overview

This guide explains how to set up and install **Terraform** on an Ubuntu server.  
It covers environment details, credentials, installation steps, and how to access the system.  

---

## 2. Environment

- **VM Name:** Terraform-Server  
- **OS:** Ubuntu Server 24.04.3 LTS  
- **IP Address:** 192.168.0.150/24  
- **Gateway:** 192.168.0.1  
- **DNS:** 1.1.1.1  
- **CPUs:** 2  
- **Memory:** 2048 MB  
- **Disk:** 40 GB  

**Prerequisites:**  

- A VM or server running Ubuntu Server 24.04  
- Internet access to fetch HashiCorp packages  

---

## 3. Credentials

- **Username:** terraform  
- **Private Key:** `~/.ssh/privatekey`

> ⚠️ Secure your SSH keys and restrict file permissions (`chmod 600 ~/.ssh/privatekey`).

---

## 4. Installation

1. Update system and install prerequisites:  

   ```bash
   sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
   ```

2. Add HashiCorp GPG key:

   ```bash
   wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
   ```

3. Verify key fingerprint:

   ```bash
   gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
   ```

4. Add Terraform repository:
   
   ```bash
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   ```

5. Update package list:
   
   ```bash
   sudo apt update
   ```

6. Install Terraform:

   ```bash
   sudo apt install terraform
   ```

---

## 5. Configuration

- Verify Terraform installation:

  ```bash
  terraform -version
  ```

---

## 6. Access

- Connect to the server via SSH:

  ```bash
  ssh -i ~/.ssh/privatekey terraform@192.168.0.150
  ```

- **Username**: terraform
- **Private Key:** `~/.ssh/privatekey`

---

## 7. Management

- Use `terraform init`, `terraform plan`, and `terraform apply` to manage infrastructure
- Update Terraform packages using `apt upgrade`
- Store state files securely

---

## 8. Appendix

- Reference: [Terraform Official Documentation](https://developer.hashicorp.com/terraform/docs)

---
