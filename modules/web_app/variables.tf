variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for the web app"
  type        = string
} 

variable "web_app_name" {
  description = "Name of the web app"
  type        = string
  default     = "kalliopi-web-app"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "app_service_plan"
}

variable "app_service_sku" {
  description = "SKU for the App Service Plan (F1=Free, B1=Basic)"
  type        = string
  default     = "B1"
}

variable "enable_vnet_integration" {
  description = "Enable VNet integration (not supported on F1 tier)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the web app"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "The ID of the subnet to deploy the web app into"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet to deploy the web app into"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account to connect to"
  type        = string
  default     = ""
}

variable "storage_account_access_key" {
  description = "Access key for the storage account"
  type        = string
  default     = ""
  sensitive   = true
}

variable "storage_connection_string" {
  description = "Connection string for the storage account"
  type        = string
  default     = ""
  sensitive   = true
}

# Key Vault secret URIs for secure access
variable "keyvault_storage_secret_uri" {
  description = "Key Vault secret URI for storage connection string"
  type        = string
  default     = ""
}

variable "keyvault_sql_secret_uri" {
  description = "Key Vault secret URI for SQL connection string"
  type        = string
  default     = ""
}

variable "keyvault_webapp_secret_uri" {
  description = "Key Vault secret URI for web app secret key"
  type        = string
  default     = ""
}

variable "keyvault_name" {
  description = "Name of the Key Vault for URL configuration"
  type        = string
  default     = ""
}