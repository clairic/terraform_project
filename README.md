# Azure Web App deployment using Terraform
In this demo project I will be using Terraform (IaC) to deploy a web app I have created on Microsoft Azure. 

### Project Diagram
There is a demo diagram in the .drawio I have created. I will add a ton of stuff so it will certainly change a lot. 


### To-do tasks 
1. Create a resource group with the name "rg-kalliopi-tsiampa" on Azure ✅
2. Create a Virtual Network (Vnet) ✅
3. Create an App Service Plan ✅
4. Create a web app (static for the time being)✅
5. Create a subnet for the web app and integrate the web app with it ✅
6. Create a Storage Account ✅
7. Create a subnet for the private endpoints ✅
8. Create a private endpoint for the storage account and connect the web app to it ✅
9. Create a private DNS zone for the storage account
10. Create a Key Vault for storing secrets 
11. Create a private endpoint for the keyvault and add it to the private endpoints subnet

### Resources that will be used
- `Resource Group`: A container in Azure that holds related resources like virtual machines, databases, and networks, allowing us to manage them together.
- `Virtual Network`: A private network that lets Azure resources securely communicate with each other, the internet, and on-premises networks.
- `Private Endpoints`: A network interface that connects you privately to an Azure service over your Virtual Network, using a private IP address instead of a public one.
- `Storage Account`: A service that provides scalable cloud storage for data like blobs, files, queues, and tables.
- `Azure App Service Plan`: In Azure, an App Service Plan defines the region, pricing tier, and compute resources used to run web apps, APIs, and functions.
- `Azure App Service`: A platform for building, hosting, and scaling web apps, REST APIs, and mobile backends without managing infrastructure.
- `Azure SQL Database`: A fully managed database service that runs SQL Server in the cloud, offering high availability, scalability, and security.
- `Azure SQL Server`:  A logical container in Azure that manages SQL databases, authentication, and firewall rules for access control.
- `KeyVault`: A service that securely stores and manages secrets like passwords, keys, and certificates.
 





