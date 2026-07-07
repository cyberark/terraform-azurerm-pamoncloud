# CyberArk PAMonCloud Terraform Package Release Notes
The PAMonCloud Terraform package includes CyberArk PAM product implementations, delivered as Terraform modules and examples to automate deployment on Azure. This solution provides enhanced flexibility and scalability for deploying core PAM components and associated infrastructure.

## [PAMonCloud Terraform on Azure v15.2] (07.07.2026)

### Added
- New `bastion` module for deploying a Bastion VM, integrated into the complete-PAM examples with related variables, outputs, and `pam_network` security rules.

### Changed
- Updated Terraform version constraints to support versions 1.9.8 through 1.13.5 across all modules and examples.

### Security
- Moved Custom Script Extension `commandToExecute` to the encrypted `protected_settings` block in the `vault`, `vault_dr`, and `component` modules.

## [PAMonCloud Terraform on Azure v15.0] (15.12.2025)

### Removed
- The vault_dr_image_id variable was removed from examples/single-region_complete-pam.

## [PAMonCloud Terraform on Azure v14.6] (1.7.2025)

### Added
- Added vault_dr_private_ip input to pvwa_vm, cpm_vm, psm_vm, and psmp_vm modules.
- Support for multiple Vault-DR private IPs.

### Changed
- Replaced storage_account_name and storage_account_access_key with storage_account_id to support VM Managed Identity authentication.

## [PAMonCloud Terraform on Azure v14.4] (12.12.2024)

### Added
- First Release of PAMonCloud over Terraform. This release of the PAMonCloud Terraform deployment tools for Azure provides enhanced flexibility and scalability.

- Cross-region deployments.

- Support for Windows Server 2022 images across all Windows-based components.

- **New Modules**: `pam_network`, `component`, `vault`, `vault_dr`  
New modules simplify the deployment of core PAM components and associated infrastructure.

- **New Examples**: `dual-region_complete-pam`, `dual-region_vault-with-dr`, `single-region_complete-pam`, `single-region_single-component`  
New examples demonstrate common deployment patterns for single and dual-region setups.