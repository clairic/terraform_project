output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_mssql_server.main.id
}

output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_admin_username" {
  description = "SQL Server administrator username"
  value       = azurerm_mssql_server.main.administrator_login
}

output "sql_admin_password" {
  description = "SQL Server administrator password"
  value       = random_password.sql_admin_password.result
  sensitive   = true
}

output "database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_mssql_database.main.id
}

output "database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.main.name
}

output "connection_string" {
  description = "SQL Database connection string"
  value       = "Server=${azurerm_mssql_server.main.fully_qualified_domain_name};Database=${azurerm_mssql_database.main.name};User Id=${azurerm_mssql_server.main.administrator_login};Password=${random_password.sql_admin_password.result};Encrypt=true;TrustServerCertificate=false;Connection Timeout=30;"
  sensitive   = true
}

# Private endpoint outputs
output "private_endpoint_id" {
  description = "ID of the SQL Server private endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.sql_pe[0].id : null
}

output "private_endpoint_ip" {
  description = "Private IP address of the SQL Server private endpoint"
  value       = var.enable_private_endpoint ? azurerm_private_endpoint.sql_pe[0].private_service_connection.0.private_ip_address : null
}

output "private_dns_zone_id" {
  description = "ID of the SQL Server private DNS zone"
  value       = var.enable_private_endpoint ? azurerm_private_dns_zone.sql_dns_zone[0].id : null
}

output "private_dns_zone_name" {
  description = "Name of the SQL Server private DNS zone"
  value       = var.enable_private_endpoint ? azurerm_private_dns_zone.sql_dns_zone[0].name : null
}
