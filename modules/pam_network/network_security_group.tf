module "network-security-group" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"

  resource_group_name = resource.azurerm_resource_group.pamoncaloud_rg.name
  use_for_each        = true
  for_each            = local.components_to_location_map
  security_group_name = "${split("-", each.key)[0]}-NSG-${each.value}"
  location            = each.value

  tags = {
    Name        = "${split("-", each.key)[0]}-NSG-${each.value}"
    Description = "Network security group for ${split("-", each.key)[0]} instances in ${each.value}"
  }

  depends_on = [resource.azurerm_resource_group.pamoncaloud_rg]
}