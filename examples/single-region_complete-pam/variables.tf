variable "vm_admin_password" {
  description = "Admin password for the VM."
  type        = string
  sensitive   = true
}

variable "vault_master_password" {
  description = "Primary Vault Master Password."
  type        = string
  sensitive   = true
}

variable "vault_admin_password" {
  description = "Primary Vault Admin Password."
  type        = string
  sensitive   = true
}

variable "vault_dr_password" {
  description = "Vault DR User Password."
  type        = string
  sensitive   = true
}

variable "vault_dr_secret" {
  description = "Vault DR User Secret."
  type        = string
  sensitive   = true
}

variable "storage_account_id" {
  description = "The resource ID of the storage account which hosts the container with the Vault license and recovery key."
  type        = string
}

variable "container_name" {
  description = "The name of the container in the storage account where Vault license and recovery key are stored."
  type        = string
  default     = ""
}

variable "vault_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}

variable "vault_dr_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}

variable "pvwa_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}

variable "cpm_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}

variable "psm_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}

variable "psmp_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}

variable "pta_image_id" {
  description = "Image ID to use for the VM deployment."
  type        = string
  default     = ""
}