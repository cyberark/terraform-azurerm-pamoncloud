resource "azurerm_public_ip" "bastion" {
  name                = "${var.vm_name}-pip-${random_uuid.random_suffix.id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Name = "${var.vm_name}-pip"
  }
}
