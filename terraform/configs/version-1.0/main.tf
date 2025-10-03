terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}

provider "proxmox" {
  endpoint      = "https://192.168.0.100:8006/api2/json"
  api_token     = "terraform@pve!terraform-token=0811a963-14f7-4f2f-af0e-6ea7efa598ec"
  insecure      = true
}

data "local_file" "ssh_public_key" {
  filename = "./proxmox_test.pub"
}

resource "proxmox_virtual_environment_vm" "cloudinit_vm" {
  node_name   = "pve"
  name        = "cloudinit-test"
  on_boot     = true

  clone {
    vm_id = 101
    full  = true
  }

  cpu {
    sockets = 2
    cores   = 1
    type    = "qemu64"
  }

  memory {
    dedicated = 2048
  }

  disk {
    size       = 40
    interface  = "scsi0"
    datastore_id = "local-lvm"
  }

  network_device {
    model  = "virtio"
    bridge = "vmbr0"
    enabled = true
  }

  agent {
    enabled = true
    type    = "virtio"
    timeout = "15m"
  }

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
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }
}
