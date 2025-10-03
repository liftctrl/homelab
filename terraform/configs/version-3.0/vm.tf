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
