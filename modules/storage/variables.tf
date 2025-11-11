variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for the web app"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the storage account"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "staticwebappstorageacc"
}

variable "virtual_network_id" {
  description = "The ID of the network to deploy the storage account into"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to deploy the storage account into"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "The subnet ID for the private endpoint"
  type        = string
}

variable "webapp_principal_id" {
  description = "Principal ID of the web app managed identity for RBAC assignment"
  type        = string
  default     = ""
}