# Get current user/client configuration
data "azurerm_client_config" "current" {}

# Create Azure Key Vault
resource "azurerm_key_vault" "main" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  # Network access rules - Allow your IP for deployment, then restrict to private endpoint
  network_acls {
    bypass                     = "AzureServices"
    default_action             = var.enable_private_endpoint ? "Deny" : "Allow"
    
    # Allow your development IP for Terraform deployment
    ip_rules                   = var.enable_private_endpoint && var.allowed_ip_addresses != [] ? var.allowed_ip_addresses : []
    
    # Allow access from specific virtual networks when not using private endpoint
    virtual_network_subnet_ids = var.enable_private_endpoint ? [] : (var.subnet_id != "" ? [var.subnet_id] : [])
  }

  # Only create access policy if object_id is valid
  dynamic "access_policy" {
    for_each = data.azurerm_client_config.current.object_id != null && data.azurerm_client_config.current.object_id != "" ? [1] : []
    
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azurerm_client_config.current.object_id

      key_permissions = [
        "Get",
        "List",
        "Update",
        "Create",
        "Import",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
      ]

      secret_permissions = [
        "Get",
        "List",
        "Set",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
      ]

      storage_permissions = [
        "Get",
        "List",
        "Update",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
      ]
    }
  }

  tags = var.tags
}

# Separate access policy for manual object ID specification (if needed)
resource "azurerm_key_vault_access_policy" "manual_access_policy" {
  count        = var.manual_object_id != "" ? 1 : 0
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.manual_object_id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]

  storage_permissions = [
    "Get",
    "List",
    "Update",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]
}

# Example secrets you can store
resource "azurerm_key_vault_secret" "storage_connection_string" {
  name         = "storage-connection-string"
  value        = var.storage_connection_string != "" ? var.storage_connection_string : "placeholder-storage-connection-string"
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault.main]
}

resource "azurerm_key_vault_secret" "webapp_secret_key" {
  name         = "webapp-secret-key"
  value        = var.webapp_secret_key
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault.main]
}

resource "azurerm_key_vault_secret" "api_key" {
  name         = "api-key"
  value        = var.api_key != "" ? var.api_key : "placeholder-api-key"
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault.main]
}

# SQL connection string secret (stored in api_key for now, or add a dedicated variable)
resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "sql-connection-string"
  value        = var.api_key != "" ? var.api_key : "placeholder-sql-connection-string"
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault.main]
}

# Private endpoint for Key Vault
resource "azurerm_private_endpoint" "keyvault_pe" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "${var.key_vault_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.key_vault_name}-psc"
    private_connection_resource_id = azurerm_key_vault.main.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# Private DNS zone for Key Vault private endpoint
resource "azurerm_private_dns_zone" "keyvault_dns_zone" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Link private DNS zone to virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "keyvault_dns_link" {
  count                 = var.enable_private_endpoint ? 1 : 0
  name                  = "${var.key_vault_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault_dns_zone[0].name
  virtual_network_id    = var.virtual_network_id

  tags = var.tags
}

# DNS A record for private endpoint
resource "azurerm_private_dns_a_record" "keyvault_dns_a" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = var.key_vault_name
  zone_name           = azurerm_private_dns_zone.keyvault_dns_zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.keyvault_pe[0].private_service_connection.0.private_ip_address]

  tags = var.tags
}