variable "vm_name" {
  description = "The name of the VM."
  type        = string
}

variable "vm_hostname" {
  description = "The hostname for the VM."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,13}[a-zA-Z0-9]$", var.vm_hostname))
    error_message = "VM hostname must be 3 to 15 characters long, contain at least one letter, and must not start or end with a hyphen."
  }
}

variable "vm_size" {
  description = "The size of the VM."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the RG."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-_.()]{1,89}$", var.resource_group_name))
    error_message = <<-EOF
      The resource group name must meet the following requirements:
        - Be between 1 and 90 characters long.
        - Start with a letter
        - Contain only alphanumeric characters, underscores (_), hyphens (-), or parentheses (()).
    EOF
  }
}

variable "location" {
  description = "The location to deploy the VM."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{5,}$", var.location))
    error_message = <<-EOF
      The location must be a valid Azure region name, matching these characteristics:
        - Lowercase letters only.
        - Alphanumeric characters and hyphens (-) are allowed.
        - No spaces or special characters.
    EOF
  }
}

variable "availability_zone" {
  description = "The availability zone of the VM."
  type        = list(string)
  validation {
    condition = can(
      regex("^(?:$|[123])$", join("", var.availability_zone))
    )
    error_message = <<-EOF
      The availability_zone can be a single-element list containing one of: "1", "2", or "3".
      Set the variable value to an empty list ([]) in case availability zone not supported in the selected location.
    EOF
  }
}

variable "subnet_id" {
  description = "Subnet ID where the Vault VM can reside."
  type        = string
  validation {
    condition = can(
      regex("^/subscriptions/[0-9a-fA-F-]+/resourceGroups/[a-zA-Z0-9-_.()]+/providers/Microsoft.Network/virtualNetworks/[a-zA-Z0-9-_()]+/subnets/[a-zA-Z0-9-_()]+$", var.subnet_id)
    )
    error_message = <<-EOF
      The provided subnet ID must follow the Azure subnet ID format:
      /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
    EOF
  }
}

variable "vm_admin_user" {
  description = "Admin username for the VM."
  type        = string
  validation {
    condition = (
      can(regex("^[a-zA-Z0-9_.-]{1,20}$", var.vm_admin_user)) &&
      !can(regex("^(Administrator|Guest|DefaultAccount|System)$", var.vm_admin_user))
    )
    error_message = <<-EOF
      The admin username must meet the following requirements:
        - Be between 1 and 20 characters long.
        - Contain only alphanumeric characters, underscores (_), hyphens (-), or periods (.).
        - Must not contain disallowed characters: \ / [ ] : ; | = , + * ? < > @ "
        - Cannot use reserved usernames such as Administrator, Guest, DefaultAccount, or System.
    EOF
  }
}

variable "vm_admin_password" {
  description = "Admin password for the VM."
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex("^.{12,123}$", var.vm_admin_password))
    error_message = "Password must be between 12 and 123 characters long."
  }
  validation {
    condition     = can(regex("[A-Z]", var.vm_admin_password))
    error_message = "Password must contain at least one uppercase letter."
  }
  validation {
    condition     = can(regex("[a-z]", var.vm_admin_password))
    error_message = "Password must contain at least one lowercase letter."
  }
  validation {
    condition     = can(regex("[~!@#$%\\^&*()=+_\\[\\]{}\\\\|;:\\.'\"<>,/?]", var.vm_admin_password))
    error_message = "Password must contain at least one special character."
  }
  validation {
    condition     = can(regex("[0-9]", var.vm_admin_password))
    error_message = "Password must contain at least one digit."
  }
}

variable "image_id" {
  description = "VM image ID."
  type        = string
  validation {
    condition = can(
      regex("^/subscriptions/[0-9a-fA-F-]{36}/resourceGroups/[a-zA-Z0-9_.-]+/providers/Microsoft.Compute/images/[a-zA-Z0-9-._()]+$", var.image_id)
    )
    error_message = <<-EOF
      The image_id must be a valid Azure image resource ID in the following format:
      /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/images/{imageName}
    EOF
  }
}

variable "component" {
  description = "The name of the PAM component."
  type        = string
  validation {
    condition     = contains(["PVWA", "CPM", "PSM", "PSMP", "PTA"], var.component)
    error_message = "Invalid component. Allowed components are: PVWA, CPM, PSM, PSMP, PTA."
  }
}

variable "vault_admin_username" {
  description = "Vault Admin Username."
  type        = string
  sensitive   = true
  default     = "Administrator"
  validation {
    condition     = can(regex("^.{1,128}$", var.vault_admin_username))
    error_message = "Vault Admin Username must be up to 128 characters long."
  }
}

variable "vault_admin_password" {
  description = "Vault Admin Password."
  type        = string
  sensitive   = true
}

variable "primary_vault_private_ip" {
  description = "The private IP address of the Primary Vault."
  type        = string
  validation {
    condition     = can(regex("^(10\\.(?:[0-9]{1,3}\\.){2}[0-9]{1,3}|172\\.(?:1[6-9]|2[0-9]|3[0-1])\\.(?:[0-9]{1,3}\\.)[0-9]{1,3}|192\\.168\\.(?:[0-9]{1,3}\\.)[0-9]{1,3})$", var.primary_vault_private_ip))
    error_message = <<-EOF
      The private IP address must not include invalid characters or out-of-range numbers.
      Valid private IP ranges:
        - 10.0.0.0 - 10.255.255.255
        - 172.16.0.0 - 172.31.255.255
        - 192.168.0.0 - 192.168.255.255
      EOF
  }
}

variable "vault_dr_private_ip" {
  description = "The private IP address of the Vault DR (if exists)."
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^$|^(10|172\\.(1[6-9]|2[0-9]|3[0-1])|192\\.168)\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})(\\s*,\\s*(10|172\\.(1[6-9]|2[0-9]|3[0-1])|192\\.168)\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3}))*$", var.vault_dr_private_ip))
    error_message = <<-EOF
      The private IP address must not include invalid characters or out-of-range numbers.
      Valid private IP ranges:
        - 10.0.0.0 - 10.255.255.255
        - 172.16.0.0 - 172.31.255.255
        - 192.168.0.0 - 192.168.255.255
      EOF
  }
}

variable "pvwa_vm_hostname" {
  description = "The hostname of the PVWA VM. (Required only when component is PTA)"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^(?:$|[a-zA-Z0-9][a-zA-Z0-9-]{1,13}[a-zA-Z0-9])$", var.pvwa_vm_hostname))
    error_message = "VM hostname must be empty or 3 to 15 characters long, contain at least one letter, and must not start or end with a hyphen."
  }
}