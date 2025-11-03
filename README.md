# 🚀 Azure Web App Infrastructure with Terraform

This project demonstrates enterprise-grade Infrastructure as Code (IaC) using Terraform to deploy a complete web application infrastructure on Microsoft Azure with private networking, security, and best practices.

## 🏗️ Architecture Overview

![Infrastructure Diagram](./diagram/infra.drawio)

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
- **Private Endpoints Subnet**: `10.0.2.0/24` - All private endpoints

### Private Endpoints
- **Storage Account**: `privatelink.blob.core.windows.net`
- **Key Vault**: `privatelink.vaultcore.azure.net`
- **SQL Server**: `privatelink.database.windows.net`

### DNS Resolution
- Private DNS zones automatically resolve service names to private IPs
- All traffic stays within the virtual network

## 🔐 Security Features

### Network Security
- ✅ **No public internet access** to databases and storage
- ✅ **Private endpoints** for all data services
- ✅ **VNet integration** for web app
- ✅ **Network ACLs** with IP restrictions

### Secrets Management
- ✅ **Azure Key Vault** stores all connection strings
- ✅ **Auto-generated passwords** for SQL Server
- ✅ **Encrypted storage** of sensitive data
- ✅ **Access policies** with least privilege

### Authentication
- ✅ **Managed identities** ready for implementation
- ✅ **Azure AD integration** prepared
- ✅ **Service principal** access controls

## 💰 Cost Optimization

| Service | SKU | Monthly Cost (Est.) | Notes |
|---------|-----|-------------------|-------|
| App Service Plan | B1 | ~$13.14 | Supports VNet integration |
| SQL Database | Basic | ~$4.90 | Perfect for development |
| Storage Account | Standard_LRS | ~$0.024/GB | Local redundancy |
| Key Vault | Standard | ~$0.03/10k ops | Pay per operation |
| **Total** | | **~$18-20/month** | Development workload |

## 🚀 Getting Started

### Prerequisites
- [Terraform](https://terraform.io) >= 1.1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with sufficient permissions

### Installation & Deployment

1. **Clone the repository**
   ```bash
   git clone https://github.com/clairic/terraform_project.git
   cd terraform_project
   ```

2. **Login to Azure**
   ```bash
   az login
   az account set --subscription "your-subscription-id"
   ```

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

4. **Review the plan**
   ```bash
   terraform plan
   ```

5. **Deploy infrastructure**
   ```bash
   terraform apply
   ```

6. **Deploy the web application**
   ```bash
   cd webapp
   npm install
   # Deploy using Azure CLI or GitHub Actions
   ```

## 📁 Project Structure

```
terraform_project/
├── 📄 main.tf                    # Main Terraform configuration
├── 📄 README.md                 # This file
├── 📄 terraform.tfstate         # Terraform state (auto-generated)
├── 📁 diagram/
│   └── 📄 infra.drawio          # Infrastructure diagram
├── 📁 modules/
│   ├── 📁 keyvault/             # Key Vault module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── 📁 network/              # Virtual Network module
│   ├── 📁 sql/                  # SQL Server & Database module
│   ├── 📁 storage/              # Storage Account module
│   └── 📁 web_app/              # App Service module
└── 📁 webapp/                   # Node.js web application
    ├── 📄 app.js                # Express server
    ├── 📄 package.json          # Dependencies
    └── 📁 public/               # Static files
        ├── index.html
        ├── style.css
        └── script.js
```

## 🔧 Configuration

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

## 🛠️ Technologies Used

- **Infrastructure**: Terraform, Azure Resource Manager
- **Compute**: Azure App Service (Linux)
- **Database**: Azure SQL Database
- **Storage**: Azure Blob Storage
- **Security**: Azure Key Vault, Private Endpoints
- **Networking**: Azure Virtual Network, Private DNS
- **Application**: Node.js, Express.js, HTML/CSS/JavaScript

## 📚 Learn More

- [Azure App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Private Endpoints](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
- [Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/)
 





