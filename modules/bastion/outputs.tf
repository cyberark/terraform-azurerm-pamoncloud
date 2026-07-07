output "private_ip" {
  value = azurerm_network_interface.bastion_network_interface.private_ip_address
}

output "public_ip" {
  description = "Public IP address of the Bastion VM."
  value       = azurerm_public_ip.bastion.ip_address
}

output "vm_name" {
  value = azurerm_virtual_machine.bastion_vm.name
}

output "vm_hostname" {
  value = var.vm_hostname
}
