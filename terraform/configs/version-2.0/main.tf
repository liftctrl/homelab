##########################################################
# Terraform Block & Provider
##########################################################
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}

##########################################################
# Provider Variables
##########################################################
variable "api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_endpoint" {
  type    = string
  default = "https://192.168.0.100:8006/api2/json"
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.api_token
  insecure  = true # set true if using self-signed cert
}

##########################################################
# VM Variables
##########################################################
variable "vm_name"        { default = "cloudinit-test" }
variable "node_name"      { default = "pve" }
variable "template_vm_id" { default = 101 }

variable "cpu_sockets"    { default = 2 }
variable "cpu_cores"      { default = 1 }
variable "cpu_type"       { default = "qemu64" }

variable "memory_size"    { default = 2048 }

variable "disk_size"      { default = 40 }
variable "disk_interface" { default = "scsi0" }
variable "datastore_id"   { default = "local-lvm" }

variable "network_bridge" { default = "vmbr0" }

variable "vm_ip"      { default = "192.168.0.200/24" }
variable "vm_gateway" { default = "192.168.0.1" }

variable "ssh_user"        { default = "test" }
variable "ssh_pubkey_file" { default = "./proxmox_test.pub" }

##########################################################
# Load SSH Public Key
##########################################################
data "local_file" "ssh_public_key" {
  filename = var.ssh_pubkey_file
}

##########################################################
# Virtual Machine Resource
##########################################################
resource "proxmox_virtual_environment_vm" "cloudinit_vm" {
  node_name = var.node_name
  name      = var.vm_name
  on_boot   = true

  clone {
    vm_id = var.template_vm_id
    full  = true
  }

  cpu {
    sockets = var.cpu_sockets
    cores   = var.cpu_cores
    type    = var.cpu_type
  }

  memory {
    dedicated = var.memory_size
  }

  disk {
    size        = var.disk_size
    interface   = var.disk_interface
    datastore_id = var.datastore_id
  }

  network_device {
    model   = "virtio"
    bridge  = var.network_bridge
    enabled = true
  }

  agent {
    enabled = true
    type    = "virtio"
    timeout = "15m"
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = var.vm_ip
        gateway = var.vm_gateway
      }
    }

    user_account {
      username = var.ssh_user
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }
}

##########################################################
# Outputs
##########################################################
output "vm_name" {
  value = proxmox_virtual_environment_vm.cloudinit_vm.name
}

output "vm_ip" {
  value = proxmox_virtual_environment_vm.cloudinit_vm.initialization[0].ip_config[0].ipv4[0].address
}
