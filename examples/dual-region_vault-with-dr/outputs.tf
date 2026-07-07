# pam_network outputs

output "rg_name" {
  value = module.pam-network.rg_name
}

output "rg_location" {
  value = module.pam-network.rg_location
}

output "vnet_location" {
  value = module.pam-network.vnet_location
}

output "vault_subnet_id" {
  value = module.pam-network.vault_subnet_id
}

output "pvwa_subnet_id" {
  value = module.pam-network.pvwa_subnet_id
}

output "cpm_subnet_id" {
  value = module.pam-network.cpm_subnet_id
}

output "psm_subnet_id" {
  value = module.pam-network.psm_subnet_id
}

output "psmp_subnet_id" {
  value = module.pam-network.psmp_subnet_id
}

output "pta_subnet_id" {
  value = module.pam-network.pta_subnet_id
}

output "public_subnet_id" {
  value = module.pam-network.public_subnet_id
}

# bastion_vm outputs (when var.deploy_bastion is true)

output "bastion_private_ip" {
  value       = var.deploy_bastion ? module.bastion[0].private_ip : null
  description = "Private IP of the Bastion VM when deploy_bastion is true."
}

output "bastion_public_ip" {
  value       = var.deploy_bastion ? module.bastion[0].public_ip : null
  description = "Public IP of the Bastion VM when deploy_bastion is true (use for RDP)."
}

output "bastion_vm_name" {
  value       = var.deploy_bastion ? module.bastion[0].vm_name : null
  description = "Name of the Bastion VM when deploy_bastion is true."
}

# vault_vm outputs

output "vault_vm_private_ip" {
  value = module.vault_vm.private_ip
}

output "vault_vm_name" {
  value = module.vault_vm.vm_name
}

output "vault_vm_availability_zone" {
  value = module.vault_vm.availability_zone
}

# vault_dr_vm outputs

output "vault_dr_vm_private_ip" {
  value = module.vault_dr_vm.private_ip
}

output "vault_dr_vm_name" {
  value = module.vault_dr_vm.vm_name
}

output "vault_dr_vm_availability_zone" {
  value = module.vault_dr_vm.availability_zone
}