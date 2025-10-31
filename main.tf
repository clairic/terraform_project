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


#Create a virtual network using the network module
module "network" {
  source = "./modules/network"
  
  vnet_name           = "demoVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}

module "web_app" {
  source = "./modules/web_app"
  
  resource_group_name     = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  app_service_plan_name  = "app-service-plan-kalliopi"
  subnet_id              = module.network.subnet_id
  subnet_name            = module.network.subnet_name
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}



