#creating the output for the virtual network id
output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.subnet.name
}

output "vnet_address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_location" {
  description = "The location of the virtual network"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_resource_group_name" {
  description = "The resource group name of the virtual network"
  value       = azurerm_virtual_network.vnet.resource_group_name
}