resource "azurerm_virtual_machine" "bastion_vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.bastion_network_interface.id]
  vm_size               = var.vm_size
  zones                 = length(var.availability_zone) > 0 ? var.availability_zone : null

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk-${random_uuid.random_suffix.id}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_hostname
    admin_username = var.vm_admin_user
    admin_password = var.vm_admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Name = var.vm_name
  }
}
