#Creating a virtual network inside the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

#Creating the subnet for my web app
resource "azurerm_subnet" "subnet"{
    name = "webapp_subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]

    # Required delegation for App Service VNet integration
    delegation {
      name = "webapp_delegation"
      service_delegation {
        name = "Microsoft.Web/serverFarms"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    }
}

# Created a dedicated subnet for private endpoints
resource "azurerm_subnet" "private_endpoint_subnet" {
    name                 = "private_endpoint_subnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.2.0/24"]
}
