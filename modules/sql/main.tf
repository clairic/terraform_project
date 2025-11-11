# Get current user/client configuration for Azure AD admin
data "azurerm_client_config" "current" {}

# Generate random password for SQL Server (avoid problematic special characters)
resource "random_password" "sql_admin_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
  # Exclude problematic characters that can break connection strings
  override_special = "!@#%^&*()-_=+[{}]|;:,.<>?"
}

# Create SQL Server
resource "azurerm_mssql_server" "main" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin_password.result
  
  # Enable public network access for troubleshooting (can be disabled later)
  public_network_access_enabled = true
  
  # Enable Azure AD authentication (only if valid object ID is provided)
  dynamic "azuread_administrator" {
    for_each = var.enable_azuread_admin && var.azuread_admin_object_id != "" ? [1] : []
    content {
      login_username = var.azuread_admin_login != "" ? var.azuread_admin_login : "aad-sqladmin"
      object_id      = var.azuread_admin_object_id
    }
  }

  tags = var.tags
}

# Create SQL Database
resource "azurerm_mssql_database" "main" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.main.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = var.database_max_size_gb
  sku_name       = var.database_sku
  zone_redundant = false

  # Enable automatic tuning and backup
  short_term_retention_policy {
    retention_days = 7
  }

  tags = var.tags
}

# Firewall rule to allow Azure services (temporarily enabled for troubleshooting)
resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Firewall rule for development access (only if public access is enabled)
resource "azurerm_mssql_firewall_rule" "dev_access" {
  count            = var.enable_dev_access && !var.enable_private_endpoint ? 1 : 0
  name             = "DeveloperAccess"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = var.dev_ip_address
  end_ip_address   = var.dev_ip_address
}

# Private endpoint for SQL Server
resource "azurerm_private_endpoint" "sql_pe" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "${var.sql_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.sql_server_name}-psc"
    private_connection_resource_id = azurerm_mssql_server.main.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# Private DNS zone for SQL Server private endpoint
resource "azurerm_private_dns_zone" "sql_dns_zone" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Link private DNS zone to virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  count                 = var.enable_private_endpoint ? 1 : 0
  name                  = "${var.sql_server_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns_zone[0].name
  virtual_network_id    = var.virtual_network_id

  tags = var.tags
}

# DNS A record for private endpoint
resource "azurerm_private_dns_a_record" "sql_dns_a" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = var.sql_server_name
  zone_name           = azurerm_private_dns_zone.sql_dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.sql_pe[0].private_service_connection.0.private_ip_address]

  tags = var.tags
}

# Virtual network rule for SQL Server (alternative to private endpoint)
resource "azurerm_mssql_virtual_network_rule" "main" {
  count     = var.enable_vnet_rule && !var.enable_private_endpoint ? 1 : 0
  name      = "${var.sql_server_name}-vnet-rule"
  server_id = azurerm_mssql_server.main.id
  subnet_id = var.subnet_id
}

# RBAC role assignment for web app managed identity to access SQL Database
resource "azurerm_role_assignment" "webapp_sql_contributor" {
  scope                = azurerm_mssql_database.main.id  
  role_definition_name = "SQL DB Contributor"
  principal_id         = var.webapp_principal_id
}
