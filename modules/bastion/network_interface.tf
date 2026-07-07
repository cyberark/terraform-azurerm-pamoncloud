resource "azurerm_network_interface" "bastion_network_interface" {
  name                = "${var.vm_name}-${random_uuid.random_suffix.id}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion.id
  }
}
