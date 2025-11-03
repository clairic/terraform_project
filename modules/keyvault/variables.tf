variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where Key Vault will be created"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault (must be globally unique)"
  type        = string
}

variable "storage_connection_string" {
  description = "Storage account connection string to store as secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "webapp_secret_key" {
  description = "Secret key for web application"
  type        = string
  default     = "default-secret-key-change-in-production"
  sensitive   = true
}

variable "api_key" {
  description = "API key for external services"
  type        = string
  default     = ""
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to Key Vault"
  type        = map(string)
  default     = {}
}

variable "enable_private_endpoint" {
  description = "Whether to enable private endpoint for Key Vault"
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "ID of the subnet for private endpoint"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "ID of the subnet for network access rules"
  type        = string
  default     = ""
}

variable "virtual_network_id" {
  description = "ID of the virtual network for DNS zone linking"
  type        = string
  default     = ""
}

variable "manual_object_id" {
  description = "Manual object ID for access policy (use if automatic detection fails)"
  type        = string
  default     = ""
}

variable "allowed_ip_addresses" {
  description = "List of IP addresses allowed to access Key Vault (for deployment/management)"
  type        = list(string)
  default     = []
}