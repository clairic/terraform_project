variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL Server (must be globally unique)"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_admin_username" {
  description = "Administrator username for SQL Server"
  type        = string
  default     = "sqladmin"
}

variable "database_sku" {
  description = "SKU for the SQL Database (Basic, S0, S1, S2, P1, P2, etc.)"
  type        = string
  default     = "Basic"
}

variable "database_max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 2
}

variable "azuread_admin_login" {
  description = "Azure AD admin login name"
  type        = string
  default     = ""
}

variable "azuread_admin_object_id" {
  description = "Azure AD admin object ID"
  type        = string
  default     = ""
}

variable "enable_dev_access" {
  description = "Enable firewall rule for development access"
  type        = bool
  default     = false
}

variable "dev_ip_address" {
  description = "Developer IP address for firewall access"
  type        = string
  default     = "0.0.0.0"
}

variable "enable_private_endpoint" {
  description = "Enable private endpoint for SQL Server"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
}

variable "enable_vnet_rule" {
  description = "Enable virtual network rule for SQL Server"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "Subnet ID for virtual network rule"
  type        = string
  default     = ""
}

variable "virtual_network_id" {
  description = "Virtual Network ID for DNS zone linking"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
