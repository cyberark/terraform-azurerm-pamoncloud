locals {
  # Network locals:
  resource_group_name        = "PAMonCloud-TF-dual-region_vault-with-dr-RG"
  vnet_cidr_primary          = "10.0.0.0/16"
  vnet_location_primary      = "westeurope"
  vnet_cidr_peered           = "10.1.0.0/16"
  vnet_location_peered       = "eastus"
  users_access_cidr          = "192.168.0.0/16"
  administrative_access_cidr = "192.168.1.0/24"

  # General locals:
  vm_admin_user = "azureadmin"

  # Primary Vault locals:
  vault_vm_name                  = "PAMonCloud-TF-PrimaryVault"
  vault_vm_hostname              = "vault"
  vault_vm_size                  = "Standard_D8s_v3"
  vault_availability_zone        = ["1"]
  vault_key_vault_name           = "PrimaryKeyVault"
  vault_license_file             = "license.xml"
  vault_recovery_public_key_file = "recpub.key"

  # DR Vault locals:
  vaultdr_vm_name        = "PAMonCloud-TF-VaultDR"
  vaultdr_vm_hostname    = "vault-dr"
  vaultdr_vm_size        = "Standard_D8s_v3"
  vaultdr_key_vault_name = "DRKeyVault"

  # Bastion locals (used when var.deploy_bastion is true):
  bastion_vm_name         = "PAMonCloud-TF-Bastion"
  bastion_vm_hostname     = "bastion"
  bastion_vm_size         = "Standard_D2as_v7"
  bastion_image_publisher = "MicrosoftWindowsServer"
  bastion_image_offer     = "WindowsServer"
  bastion_image_sku       = "2022-datacenter-g2"
  bastion_image_version   = "latest"
}

provider "azurerm" {
  features {}
}

################################################################################
# pam_network Module
################################################################################
module "pam-network" {
  source = "../../modules/pam_network"

  resource_group_name        = local.resource_group_name
  vnet_location_primary      = local.vnet_location_primary
  vnet_cidr_primary          = local.vnet_cidr_primary
  vnet_location_peered       = local.vnet_location_peered
  vnet_cidr_peered           = local.vnet_cidr_peered
  users_access_cidr          = local.users_access_cidr
  administrative_access_cidr = local.administrative_access_cidr
  bastion_access_cidr        = var.bastion_access_cidr
}

################################################################################
# bastion Module (optional)
################################################################################
module "bastion" {
  count  = var.deploy_bastion ? 1 : 0
  source = "../../modules/bastion"

  vm_name             = local.bastion_vm_name
  vm_hostname         = local.bastion_vm_hostname
  vm_size             = local.bastion_vm_size
  resource_group_name = module.pam-network.rg_name
  location            = module.pam-network.vnet_location.primary
  availability_zone   = []
  subnet_id           = module.pam-network.public_subnet_id.primary
  vm_admin_user       = local.vm_admin_user
  vm_admin_password   = var.vm_admin_password
  image_publisher     = local.bastion_image_publisher
  image_offer         = local.bastion_image_offer
  image_sku           = local.bastion_image_sku
  image_version       = local.bastion_image_version

  depends_on = [module.pam-network]
}

################################################################################
# vault Module
################################################################################
module "vault_vm" {
  source = "../../modules/vault"

  vm_name             = local.vault_vm_name
  vm_hostname         = local.vault_vm_hostname
  vm_size             = local.vault_vm_size
  resource_group_name = module.pam-network.rg_name
  location            = module.pam-network.vnet_location.primary
  availability_zone   = local.vault_availability_zone
  subnet_id = {
    primary = module.pam-network.vault_subnet_id.primary
    peered  = module.pam-network.vault_subnet_id.peered
  }
  vm_admin_user            = local.vm_admin_user
  vm_admin_password        = var.vm_admin_password
  image_id                 = var.vault_image_id
  storage_account_id       = var.storage_account_id
  container_name           = var.container_name
  license_file             = local.vault_license_file
  recovery_public_key_file = local.vault_recovery_public_key_file
  key_vault_name           = local.vault_key_vault_name
  vault_master_password    = var.vault_master_password
  vault_admin_password     = var.vault_admin_password
  vault_dr_password        = var.vault_dr_password
  vault_dr_secret          = var.vault_dr_secret

  depends_on = [module.pam-network]
}

################################################################################
# vault_dr Module
################################################################################
module "vault_dr_vm" {
  source = "../../modules/vault_dr"

  vm_name             = local.vaultdr_vm_name
  vm_hostname         = local.vaultdr_vm_hostname
  vm_size             = local.vaultdr_vm_size
  resource_group_name = module.pam-network.rg_name
  location            = module.pam-network.vnet_location.peered == null ? module.pam-network.vnet_location.primary : module.pam-network.vnet_location.peered
  availability_zone   = [module.vault_vm.availability_zone == "1" ? "2" : "1"]
  subnet_id = {
    primary = module.pam-network.vault_subnet_id.primary
    peered  = module.pam-network.vault_subnet_id.peered
  }
  vm_admin_user            = local.vm_admin_user
  vm_admin_password        = var.vm_admin_password
  image_id                 = var.vault_dr_image_id
  key_vault_name           = local.vaultdr_key_vault_name
  vault_dr_password        = var.vault_dr_password
  vault_dr_secret          = var.vault_dr_secret
  primary_vault_private_ip = module.vault_vm.private_ip

  depends_on = [module.pam-network, module.vault_vm]
}