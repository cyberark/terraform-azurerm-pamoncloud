variable "vm_name" {
  description = "The name of the Bastion VM."
  type        = string
}

variable "vm_hostname" {
  description = "The hostname for the Bastion VM."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,13}[a-zA-Z0-9]$", var.vm_hostname))
    error_message = "VM hostname must be 3 to 15 characters long, contain at least one letter, and must not start or end with a hyphen."
  }
}

variable "vm_size" {
  description = "The size of the Bastion VM."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
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
  description = "The location to deploy the Bastion VM."
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
  description = "The availability zone of the Bastion VM."
  type        = list(string)
  default     = []
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
  description = "Subnet ID where the Bastion VM resides (Public-Subnet)."
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
  description = "Admin username for the Bastion VM."
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
        - Cannot use reserved usernames such as Administrator, Guest, DefaultAccount, or System.
    EOF
  }
}

variable "vm_admin_password" {
  description = "Admin password for the Bastion VM."
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

variable "image_publisher" {
  description = "The publisher of the image used to create the Bastion VM."
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "The offer of the image used to create the Bastion VM."
  type        = string
  default     = "WindowsServer"
}

variable "image_sku" {
  description = "The SKU of the image used to create the Bastion VM."
  type        = string
  default     = "2022-datacenter-g2"
}

variable "image_version" {
  description = "The version of the image used to create the Bastion VM."
  type        = string
  default     = "latest"
}
