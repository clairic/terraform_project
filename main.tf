# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}


#creating a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-kalliopi-tsiampa"
  location = "northeurope"

  tags = {
    Environment = "Terraform Getting Started"
    location = "northeurope"
  }
}

#Create a virtual network inside the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "demoVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.rg.name
}

#Creating a storage account with the cheapest SKUs

resource "azurerm_storage_account" "storageacc" {
  name                     = "azdemostoracc"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "northeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
    location = "North Europe"
  }
}