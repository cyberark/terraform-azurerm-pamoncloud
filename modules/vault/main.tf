resource "random_string" "unique_suffix" {
  length  = 8
  upper   = false
  special = false
}

data "azurerm_virtual_machine" "vault_vm_data" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name

  depends_on = [resource.azurerm_virtual_machine.primary_vault_vm]
}