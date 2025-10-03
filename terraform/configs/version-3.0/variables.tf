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
