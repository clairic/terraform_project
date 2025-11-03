output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.main.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "key_vault_tenant_id" {
  description = "Tenant ID of the Key Vault"
  value       = azurerm_key_vault.main.tenant_id
}

# Secret references for use in other modules
output "storage_connection_string_secret_id" {
  description = "Key Vault secret ID for storage connection string"
  value       = azurerm_key_vault_secret.storage_connection_string.id
}

output "webapp_secret_key_secret_id" {
  description = "Key Vault secret ID for webapp secret key"
  value       = azurerm_key_vault_secret.webapp_secret_key.id
}

output "api_key_secret_id" {
  description = "Key Vault secret ID for API key"
  value       = azurerm_key_vault_secret.api_key.id
}

output "sql_connection_string_secret_id" {
  description = "Key Vault secret ID for SQL connection string"
  value       = azurerm_key_vault_secret.sql_connection_string.id
}

# Private endpoint outputs
output "private_endpoint_id" {
  description = "ID of the Key Vault private endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.keyvault_pe[0].id : null
}

output "private_endpoint_ip" {
  description = "Private IP address of the Key Vault private endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.keyvault_pe[0].private_service_connection.0.private_ip_address : null
}

output "private_dns_zone_id" {
  description = "ID of the Key Vault private DNS zone"
  value       = var.enable_private_endpoint ? azurerm_private_dns_zone.keyvault_dns_zone[0].id : null
}