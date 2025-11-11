#Creating the app service plan for my web app
resource "azurerm_service_plan" "app_service_plan" {
    name                = var.app_service_plan_name
    location            = var.location
    resource_group_name = var.resource_group_name
    os_type             = "Linux"
    sku_name            = var.app_service_sku
    
    tags = var.tags
}

#Creating the web app for testing
resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  # Enable system-assigned managed identity for RBAC
  identity {
    type = "SystemAssigned"
  }
 
  site_config {
    always_on = false
    
    application_stack {
      node_version = "16-lts"
    }
  }

  # App settings using Key Vault references (secure access via managed identity)
  app_settings = {
    # Azure Key Vault URL for the app to access secrets
    "KEY_VAULT_URL"              = "https://${var.keyvault_name}.vault.azure.net/"
    "STORAGE_ACCOUNT_NAME"       = var.storage_account_name
    # Use Key Vault references with VaultName format (more reliable than SecretUri)
    "STORAGE_CONNECTION_STRING"  = var.keyvault_name != "" ? "@Microsoft.KeyVault(VaultName=${var.keyvault_name};SecretName=storage-connection-string)" : var.storage_connection_string
    "SQL_CONNECTION_STRING"      = var.keyvault_name != "" ? "@Microsoft.KeyVault(VaultName=${var.keyvault_name};SecretName=sql-connection-string)" : ""
    "WEBAPP_SECRET_KEY"          = var.keyvault_name != "" ? "@Microsoft.KeyVault(VaultName=${var.keyvault_name};SecretName=webapp-secret-key)" : ""
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_NODE_DEFAULT_VERSION" = "16.20.0"
    # Enable managed identity authentication
    "AZURE_CLIENT_ID"            = "system"
    # Node.js production optimizations
    "NODE_ENV"                   = "production"
    "NPM_CONFIG_PRODUCTION"      = "true"
    # Private endpoint connectivity settings (critical for VNet integration)
    "WEBSITE_VNET_ROUTE_ALL"     = "1"
    "WEBSITE_DNS_SERVER"         = "168.63.129.16"
  }

  tags = var.tags
}

# Creating VNet integration for the web app (only if enabled and supported by SKU)
resource "azurerm_app_service_virtual_network_swift_connection" "webapp_vnet_integration" {
  count          = var.enable_vnet_integration ? 1 : 0
  app_service_id = azurerm_linux_web_app.webapp.id
  subnet_id      = var.subnet_id
}