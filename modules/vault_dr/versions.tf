terraform {
  required_version = ">= 1.9.8, <= 1.13.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}