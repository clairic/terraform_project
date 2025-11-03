#Creating the app service plan for my web app
resource "azurerm_service_plan" "app_service_plan" {
    name                = var.app_service_plan_name
    location            = var.location
    resource_group_name = var.resource_group_name
    os_type             = "Linux"
    sku_name            = var.app_service_sku
    
    tags = var.tags
}

#Creating the static web app for testing
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-kalliopi"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    always_on = false
    
    application_stack {
      node_version = "16-lts"
    }
  }

  # App settings for storage connection
  app_settings = {
    "STORAGE_ACCOUNT_NAME"       = var.storage_account_name
    "STORAGE_CONNECTION_STRING"  = var.storage_connection_string
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_NODE_DEFAULT_VERSION" = "16.20.0"
  }

  tags = var.tags
}

# Creating VNet integration for the web app (only if enabled and supported by SKU)
resource "azurerm_app_service_virtual_network_swift_connection" "webapp_vnet_integration" {
  count          = var.enable_vnet_integration ? 1 : 0
  app_service_id = azurerm_linux_web_app.webapp.id
  subnet_id      = var.subnet_id
}