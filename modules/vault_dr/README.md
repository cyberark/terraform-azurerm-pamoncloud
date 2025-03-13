# PAMonCloud for Azure - Vault DR Terraform Module

This module deploys and manages the **Vault Disaster Recovery (Vault DR)** component as an VM within an Azure environment. It is designed to replicate the primary Vault and provides high availability for the Vault service.

## Usage

```hcl
module "vault_dr_vm" {
    source = "cyberark/pamoncloud/azurerm//modules/vault_dr"

    vm_name             = "VaultDR"
    vm_hostname         = "vault-dr"
    vm_size             = "Standard_D8s_v3"
    resource_group_name = "ResourceGroupName"
    location            = "westeurope"
    availability_zone   = ["2"]
    subnet_id           = {
      primary   = "/subscriptions/abcd1234-abcd-1234-5678-efghijklmnop/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVNet/subnets/subnet-primary"
      peered    = "/subscriptions/abcd1234-abcd-1234-5678-efghijklmnop/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVNet/subnets/subnet-peered"
    }
    vm_admin_user                   = "azureadmin"
    vm_admin_password               = "VaultAdminPassword"
    image_id                        = "/subscriptions/12345678-1234-5678-1234-567812345678/resourceGroups/PAM-Images/providers/Microsoft.Compute/images/Component-Image"
    key_vault_name                  = "vault-dr-key-vault"
    vault_dr_password               = "VaultDrPassword"
    vault_dr_secret                 = "VaultDrSecret"
    primary_vault_private_ip        = "10.0.1.1"
}
```

## Examples

- [single-region_complete-pam](/examples/single-region_complete-pam) with Vault DR.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](https://github.com/hashicorp/terraform) | 1.9.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](https://github.com/hashicorp/terraform-provider-azurerm) | 3.116.0 |
| <a name="requirement_random"></a> [random](https://github.com/hashicorp/terraform-provider-random) | 3.6.2 |
| <a name="requirement_null"></a> [null](https://github.com/hashicorp/terraform-provider-null) | 3.2.3 |

## Modules

No modules.

## Resources

### Retrieve information about a resource (post deployment)
You can use the `terraform state show` command followed by: `module.<module_name>.<resource_name>`  
Example: `terraform state show 'module.vault_dr_vm.azurerm_key_vault.vault_dr_key_vault'`  

### Network Resources
| Resource                                                                                     | Description                                                  |
|----------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `azurerm_key_vault.vault_dr_key_vault`                                                       | The key vault for Vault DR (Disaster Recovery).              |
| `azurerm_network_interface.vault_dr_network_interface`                                       | The network interface for the Vault DR virtual machine.      |

### VM Resources
| Resource                                                           | Description                                                               |
|--------------------------------------------------------------------|---------------------------------------------------------------------------|
| `azurerm_virtual_machine.valut_dr_vm`                              | The Vault DR virtual machine for disaster recovery.                       |
| `azurerm_virtual_machine_extension.registration_script`            | The registration script for the Vault DR VM.                              |
| `data.azurerm_virtual_machine.vault_vm_data`                       | Data about the Vault VM, used for additional configuration or management. |

#### **Miscellaneous**
| Resource                    | Description                                    |
|-----------------------------|------------------------------------------------|
| `random_string.unique_suffix` | A randomly generated suffix for unique naming. |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the VM. | `string` | `null` | yes |
| <a name="input_vm_hostname"></a> [vm\_hostname](#input\_vm\_hostname) | The hostname for the VM. Must be 3 to 15 characters long, contain at least one letter, and must not start or end with a hyphen. | `string` | `null` | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the VM. | `string` | `null` | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. Must be between 1 and 90 characters long, start with a letter, and contain only alphanumeric characters, underscores, hyphens, or parentheses. | `string` | `null` | yes |
| <a name="input_location"></a> [location](#input\_location) | The location to deploy the VM. Must be a valid Azure region name matching lowercase letters, alphanumerics, and hyphens only. | `string` | `null` | yes |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The availability zone of the VM. Can be an empty list or a list with values "1", "2", or "3". | `list(string)` | `["2"]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID where the Vault VM can reside. Must follow Azure subnet ID format. | `type = object({ primary = string peered = optional(string)})` | `null` | yes |
| <a name="input_vm_admin_user"></a> [vm\_admin\_user](#input\_vm\_admin\_user) | Admin username for the VM. Must only contain alphanumerics, underscores, periods, or hyphens. Reserved usernames such as Administrator, Guest, and System cannot be used. | `string` | `null` | yes |
| <a name="input_vm_admin_password"></a> [vm\_admin\_password](#input\_vm\_admin\_password) | Admin password for the VM. Password must be between 12 and 123 characters long, must contain at least one uppercase letter, one lowercase letter, one number, and one special character. | `string` | `null` | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | VM image ID. Must follow the Azure image resource ID format. | `string` | `null` | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The name of the key vault. Must adhere to Azure naming conventions. | `string` | `null` | yes |
| <a name="input_vault_dr_password"></a> [vault\_dr\_password](#input\_vault\_dr\_password) | Vault DR user password. Must have at least 10 characters, with one uppercase, one lowercase, one special character, and one number. | `string` | `null` | yes |
| <a name="input_vault_dr_secret"></a> [vault\_dr\_secret](#input\_vault\_dr\_secret) | Vault DR user secret. Required only for DR implementations. | `string` | `null` | yes |
| <a name="input_primary_vault_private_ip"></a> [primary\_vault\_private\_ip](#input\_primary\_vault\_private\_ip) | Primary Vault private IP. | `string` | `null` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address of the network interface. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the virtual machine deployed. |
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The availability zone |

<!-- END_TF_DOCS -->