# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

#creating a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-kalliopi-tsiampa"
  location = "northeurope"

  tags = {
    Environment = "Terraform Getting Started"
    location = "northeurope"
  }
}

#Creating a private DNS zone for storage account
resource "azurerm_private_dns_zone" "storage_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}


#Create a virtual network using the network module
module "network" {
  source = "./modules/network"
  
  vnet_name           = "demoVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}

module "web_app" {
  source = "./modules/web_app"
  
  resource_group_name         = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  web_app_name               = "kalliopi-web-app"
  app_service_plan_name      = "app-service-plan-kalliopi"
  app_service_sku            = "B1"  # Use B1 for VNet integration, F1 for cheapest
  enable_vnet_integration    = true  # Set to false if using F1 SKU
  subnet_id                  = module.network.subnet_id
  subnet_name                = module.network.subnet_name
  
  # Storage connection
  storage_account_name       = module.storage.storage_account_name
  storage_connection_string  = module.storage.storage_account_primary_connection_string
  storage_account_access_key = module.storage.storage_account_primary_access_key
  
  # Key Vault references for secure secret access
  keyvault_name               = module.keyvault.key_vault_name
  keyvault_storage_secret_uri = module.keyvault.storage_connection_string_secret_uri
  keyvault_sql_secret_uri     = module.keyvault.sql_connection_string_secret_uri
  keyvault_webapp_secret_uri  = module.keyvault.webapp_secret_key_secret_uri
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}

module "storage" {
  source = "./modules/storage"
  
  resource_group_name           = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  storage_account_name         = "kalliopistorageacc"
  virtual_network_id           = module.network.vnet_id
  virtual_network_name         = module.network.vnet_name
  private_endpoint_subnet_id   = module.network.private_endpoint_subnet_id
  
  # RBAC configuration
  webapp_principal_id          = module.web_app.webapp_identity_principal_id
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}

# Generate random suffix for unique Key Vault naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Create Azure Key Vault for storing secrets
module "keyvault" {
  source = "./modules/keyvault"
  
  resource_group_name         = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  key_vault_name             = "kv-kalliopi-${random_string.suffix.result}"
  storage_connection_string  = module.storage.storage_account_primary_connection_string
  webapp_secret_key          = "my-super-secret-webapp-key-${random_string.suffix.result}"
  sql_connection_string      = module.sql.connection_string  # Store SQL connection string
  
  # RBAC configuration
  webapp_principal_id         = module.web_app.webapp_identity_principal_id
  
  # Manual object ID to fix access policy issue
  manual_object_id            = "3f8e8156-22ed-4dc8-a23e-ca8355d2bb77"
  
  # Allow your IP for Terraform deployment (from error message)
  allowed_ip_addresses        = ["79.129.238.27", "2.86.114.255"]
  
  # Private endpoint configuration
  enable_private_endpoint     = true
  private_endpoint_subnet_id  = module.network.private_endpoint_subnet_id
  subnet_id                   = module.network.subnet_id
  virtual_network_id          = module.network.vnet_id
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}

# Create SQL Server and Database with private endpoint
module "sql" {
  source = "./modules/sql"
  
  resource_group_name         = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  sql_server_name            = "sql-kalliopi-${random_string.suffix.result}"
  database_name              = "webapp-db"
  sql_admin_username         = "sqladmin"
  database_sku               = "Basic"
  database_max_size_gb       = 2
  
  # Azure AD configuration
  enable_azuread_admin       = true
  azuread_admin_object_id    = "3f8e8156-22ed-4dc8-a23e-ca8355d2bb77"  # Use same as Key Vault
  azuread_admin_login        = "aad-sqladmin"  # Different from SQL admin username
  webapp_principal_id        = module.web_app.webapp_identity_principal_id
  
  # Private endpoint configuration
  enable_private_endpoint     = true
  private_endpoint_subnet_id  = module.network.private_endpoint_subnet_id
  virtual_network_id          = module.network.vnet_id
  
  # Optional: Development access (disable for production)
  enable_dev_access          = false
  dev_ip_address             = "0.0.0.0"  # No external access allowed
  enable_vnet_rule           = false      # Not needed with private endpoint
  subnet_id                  = module.network.subnet_id
  
  tags = {
    Environment = "Terraform Getting Started"
    location    = "northeurope"
  }
}

# Outputs for deployment information
output "app_service_name" {
  description = "Name of the App Service"
  value       = module.web_app.webapp_name
}

output "app_service_url" {
  description = "URL of the deployed App Service"
  value       = module.web_app.webapp_url
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = module.keyvault.key_vault_name
}

output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = module.sql.sql_server_name
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = module.storage.storage_account_name
}