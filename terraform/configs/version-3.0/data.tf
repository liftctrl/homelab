##########################################################
# Load SSH Public Key
##########################################################
data "local_file" "ssh_public_key" {
  filename = var.ssh_pubkey_file
}
