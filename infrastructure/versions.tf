terraform {
  required_version = "~>1.0"
  backend "azurerm" {

  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.87.0"
    }
  }
}