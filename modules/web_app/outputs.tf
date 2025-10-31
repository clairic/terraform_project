output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.id
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.name
}

output "app_service_plan_location" {
  description = "The location of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.location
}

output "app_service_plan_resource_group_name" {
  description = "The resource group name of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.resource_group_name
}

output "app_service_plan_os_type" {
  description = "The OS type of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.os_type
}

output "app_service_plan_sku_name" {
  description = "The SKU name of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.sku_name
}

output "webapp_id" {
  description = "The ID of the web app"
  value       = azurerm_linux_web_app.webapp.id
}

output "webapp_name" {
  description = "The name of the web app"
  value       = azurerm_linux_web_app.webapp.name
}

output "webapp_default_hostname" {
  description = "The default hostname of the web app"
  value       = azurerm_linux_web_app.webapp.default_hostname
}

output "webapp_url" {
  description = "The URL of the web app"
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}

