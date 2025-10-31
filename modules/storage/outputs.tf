output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_web_endpoint" {
  description = "The primary web endpoint of the storage account"
  value       = azurerm_storage_account.storage_account.primary_web_endpoint
}

output "storage_account_resource_group_name" {
  description = "The resource group name of the storage account"
  value       = azurerm_storage_account.storage_account.resource_group_name
}

output "storage_account_location" {
  description = "The location of the storage account"
  value       = azurerm_storage_account.storage_account.location
}

output "storage_account_tags" {
  description = "The tags of the storage account"
  value       = azurerm_storage_account.storage_account.tags
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = azurerm_storage_account.storage_account.primary_connection_string
  sensitive   = true
}

output "private_endpoint_id" {
  description = "The ID of the storage private endpoint"
  value       = azurerm_private_endpoint.storage_private_endpoint.id
}


