locals {
  vault_ips = var.vault_dr_private_ip == "" ? var.primary_vault_private_ip : "${var.primary_vault_private_ip},${var.vault_dr_private_ip}"
}

resource "random_uuid" "random_suffix" {
}