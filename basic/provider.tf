terraform {
  # specify terraform version to use
  required_version = "~>1.7.0"

  # Providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.0"
    }
  }
}

# Provider configuration
provider "azurerm" {

  # subscription_id = "xxxxxx"

  features {}
}

