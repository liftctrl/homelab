# My Home Lab

Welcome to my personal **homelab**! This setup is designed for **learning, experimentation, and testing** in virtualization, networking, and infrastructure automation.  
It provides a compact but capable environment to run virtual machines, explore new software, and manage personal projects.

Below is an overview of the **hardware**, **software**, and **active hosts** in my lab.

---

## 1. Hardware


| Component | Specification                          |
|-----------|----------------------------------------|
| Model     | DELL Optiplex 5070 MFF                 |
| CPU       | Intel i5-9500T (6 cores / 6 threads)  |
| RAM       | 32 GB DDR4                              |
| Storage   | 512 GB SSD                              |
| Network   | Integrated Gigabit Ethernet             |


---

## 2. Software


| Component  | Version | Purpose                     |
|------------|---------|-----------------------------|
| Proxmox VE | 9.0-1   | Hypervisor & VM management  |


---

## 3. Hosts / VMs Overview


| Name           | Role / Description               | Operating System        | IP Address / Subnet  |
|----------------|---------------------------------|------------------------|--------------------|
| Proxmox Host    | Hypervisor (management node)    | Proxmox VE 9.0-1       | 192.168.0.100/24   |
| Terraform       | Infra-as-code automation server | Ubuntu Server 22.04 LTS| 192.168.0.150/24   |


---
