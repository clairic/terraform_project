# Azure Web App deployment using Terraform
In this demo project I will be creating a web app using Terraform (IaC) on Microsoft Azure. 

### Project Diagram
There is a demo diagram in the .drawio I have created. I will add a ton of stuff so it will certainly change a lot. 


### To-do tasks 
1. Create a resource group with the name "rg-kalliopi-tsiampa" on Azure ✅
2. Create a Virtual Network (Vnet) with the name "demoVnet" ✅
3. Create a Storage Account with the name "azdemostoracc" ✅
4. Create subnets in the same Vnet (demoVnet), one for the web app (webapp_subnet), one for the sql database (sql_subnet), one for the keyvault (keyvault_subnet) ✅
5. Create Private Endpoints to ensure privacy and block unauthorized access.
6. Use Role Based Access (RBAC) to allow access to whomever needs it and block access from others
7. Connect the different resources with each other correctly 

### Resources that will be used
- `Resource Group`: A container in Azure that holds related resources like virtual machines, databases, and networks, allowing us to manage them together.
- `Virtual Network`: A private network that lets Azure resources securely communicate with each other, the internet, and on-premises networks.
- `Storage Account`: A service that provides scalable cloud storage for data like blobs, files, queues, and tables.
- `Azure App Service Plan`: In Azure, an App Service Plan defines the region, pricing tier, and compute resources used to run web apps, APIs, and functions.
- `Azure App Service`: A platform for building, hosting, and scaling web apps, REST APIs, and mobile backends without managing infrastructure.
- `Azure SQL Database`: A fully managed database service that runs SQL Server in the cloud, offering high availability, scalability, and security.
- `Azure SQL Server`:  A logical container in Azure that manages SQL databases, authentication, and firewall rules for access control.
- `KeyVault`: A service that securely stores and manages secrets like passwords, keys, and certificates.
 





