resource "azurerm_network_interface" "primary_vault_network_interface" {
  name                = "${var.vm_name}-${random_uuid.random_suffix.id}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id.primary
    private_ip_address_allocation = "Dynamic"
  }
}