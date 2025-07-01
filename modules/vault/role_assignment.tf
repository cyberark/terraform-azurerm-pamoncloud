resource "azurerm_role_assignment" "storage_account_role_assignment" {
  scope                = var.storage_account_id
  role_definition_name = local.vm_role_assignment_role
  principal_id         = data.azurerm_virtual_machine.vault_vm_data.identity[0].principal_id

  depends_on = [resource.azurerm_virtual_machine.primary_vault_vm]
}