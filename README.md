# 🚀 Azure Web App Infrastructure with Terraform

In this project I worked on deploying a dynamic web app on Azure. I created the infrastructure using Terraform (IaC). 

## 🏗️ Architecture Overview

> **📋 View Diagram**: 

![Infrastructure Diagram](./diagram/infra_img.png)

The infrastructure includes:
- **Private networking** with VNet integration
- **Security** through private endpoints and Key Vault
- **Scalability** with App Service and SQL Database
- **Storage** with private endpoint configuration
- **Secrets management** with Azure Key Vault

## 📋 Project Status

### ✅ Completed Features
- [x] Resource Group (`rg-kalliopi-tsiampa`)
- [x] Virtual Network with custom subnets
- [x] App Service Plan (B1 SKU)
- [x] Linux Web App with Node.js runtime
- [x] VNet integration for web app
- [x] Storage Account with private endpoint
- [x] Private endpoints subnet
- [x] Private DNS zones for name resolution
- [x] **Azure Key Vault with private endpoint**
- [x] **SQL Server and Database with private endpoint**
- [x] **Complete private networking setup**

### 🎯 Key Features Implemented
- **🔒 Private Endpoints**: All services isolated from internet
- **🌐 VNet Integration**: Secure communication between services
- **🔐 Azure Key Vault**: Centralized secrets management
- **🗄️ SQL Database**: Managed database with private access
- **📦 Storage Account**: Blob storage with private endpoint
- **🛡️ Network Security**: Default deny with controlled access

## 🏛️ Infrastructure Components

| Component | Description | SKU/Tier | Security |
|-----------|-------------|----------|----------|
| **Resource Group** | Container for all resources | Standard | ✅ |
| **Virtual Network** | Private network (10.0.0.0/16) | Standard | ✅ Private |
| **App Service Plan** | Compute for web applications | B1 (Basic) | ✅ VNet Integrated |
| **Linux Web App** | Node.js 16 web application | B1 | ✅ Private Access |
| **Storage Account** | Blob storage for app data | Standard_LRS | ✅ Private Endpoint |
| **SQL Server** | Managed database server | Basic | ✅ Private Endpoint |
| **SQL Database** | Application database (2GB) | Basic | ✅ Private Access |
| **Key Vault** | Secrets and configuration | Standard | ✅ Private Endpoint |

## 🌐 Network Architecture

### Subnets
- **Web App Subnet**: `10.0.1.0/24` - VNet integration
- **Private Endpoints Subnet**: `10.0.2.0/24` - All the private endpoints are placed here

### Private Endpoints
- **Storage Account**: `privatelink.blob.core.windows.net`
- **Key Vault**: `privatelink.vaultcore.azure.net`
- **SQL Server**: `privatelink.database.windows.net`

### DNS Resolution
- Private DNS zones automatically resolve service names to private IPs
- All traffic stays within the virtual network

### Environment Variables
Key configuration is managed through Terraform variables and Azure Key Vault:

- **SQL Connection String**: Stored in Key Vault
- **Storage Connection String**: Stored in Key Vault
- **Application Secrets**: Stored in Key Vault

### Terraform Variables
Key variables in `main.tf`:
- `location`: Azure region (default: North Europe)
- `resource_group_name`: Container for resources
- `app_service_sku`: App Service tier (B1/F1)
- `enable_private_endpoint`: Enable private networking





