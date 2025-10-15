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

#Creating a subnet for the web app
resource "azurerm_subnet" "webappsubnet"{
name = "webapp_subnet"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.1.0/24"]
}

#Creating a subnet for the sql database and server
resource "azurerm_subnet" "sqlsubnet"{
  name = "sql_subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.0.2.0/24"]
}

#Creating a subnet for the keyvault
resource "azurerm_subnet" "keyvaultsubnet"{
  name = "keyvault_subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes = ["10.0.3.0/24"]
}

#Creating a storage account with the cheapest SKUs
resource "azurerm_storage_account" "storageacc" {
  name                     = "azdemostoracc"
  resource_group_name = azurerm_resource_group.rg.name
  location                 = "northeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
    location = "North Europe"
  }
}

#Creating an SQL server and a database inside the resource group and the sql_subnet subnet I created before
resource "azurerm_mssql_server" "sqlserver" {
  name                         = "azdemosqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = "northeurope"
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "H@Sh1CoR3!"

  tags = {
    environment = "staging"
    location = "North Europe"
  }
}

resource "azurerm_mssql_database" "sqldatabase" {
  name      = "azdemosqldb"
  server_id = azurerm_mssql_server.sqlserver.id
  
  # Use sku_name instead of edition for service tier
  sku_name = "Basic"
  
  # Optional: Set max size (in GB)
  max_size_gb = 2

  tags = {
    environment = "staging"
    location = "North Europe"
  }
}