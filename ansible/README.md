# Ansible Guide

## 1. Overview

This guide explains how to install and configure **Ansible** on an Ubuntu server.  
It covers environment details, credentials, installation steps, and basic usage notes.  

---

## 2. Environment

- **VM Name:** Ansible-Server  
- **OS:** Ubuntu Server 24.04.3 LTS  
- **IP Address:** 192.168.0.151/24  
- **Gateway:** 192.168.0.1  
- **DNS:** 1.1.1.1  
- **CPUs:** 2  
- **Memory:** 2048 MB  
- **Disk:** 40 GB  

**Prerequisites:**  

- A VM or server running Ubuntu Server 24.04  
- Internet access to fetch Ansible packages  

---

## 3. Credentials

- **Username:** ansible  
- **Private Key:** `~/.ssh/privatekey`  

> ⚠️ Secure your SSH keys and restrict file permissions (`chmod 600 ~/.ssh/privatekey`).  

---

## 4. Installation

1. Update package list:  

   ```bash
   sudo apt update
   ```

2. Install prerequisites:

   ```bash
   sudo apt install -y software-properties-common
   ```
3. Add Ansible PPA repository:
   
   ```bash
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   ```

4. Install Ansible:

   ```bash
   sudo apt install -y ansible
   ```

---

## 5. Configuration

- Verify installation:
  
  ```bash
  ansible --version
  ```

- Create an inventory file (e.g. `/etc/ansible/hosts`)
- Set up SSH key-based authentication to managed nodes

---

## 6. Access

- Connect to the Ansible server:
  
  ```bash
  ssh ansible@192.168.0.151
  ```

- Use Ansible commands directly from the CLI:

  ```bash
  ansible all -m ping
  ```

---

## 7. Management

- Update Ansible:

  ```bash
  sudo apt update && sudo apt upgrade
  ```

- Manage inventories and playbooks in /etc/ansible/
- Common commands:
  - `ansible-playbook <playbook.yml>`
  - `ansible all -m ping`

---

## 8. Appendix

- **Reference:** [Ansible Official Documentation](https://docs.ansible.com/)

---
