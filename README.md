[![.github/workflows/deploy.yml](https://github.com/haripraghash/resilientazureapi/actions/workflows/deploy.yml/badge.svg?branch=main)](https://github.com/haripraghash/resilientazureapi/actions/workflows/deploy.yml)
# resilientazureapi
A sample repo demonstrating a http api deployment on azure over multi-az

![Deployment view](https://github.com/haripraghash/resilientapi/blob/main/Deploymentview.png?raw=true)

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [.Net Core SDK](https://dotnet.microsoft.com/download/dotnet/6.0)
- [Azure Subscription]
- [2 Resource groups - 1 For TF remote state and 1 for deploying the api]
- [Log Analytics Workspace]
- [Azurite](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=npm)

### Installation

``` shell
git clone https://github.com/haripraghash/resilientazureapi.git
cd resilientazureapi/infrastructure
```

### Quickstart

There are [different ways](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html) to authenticate with the Azure provider via Terraform. This example uses a Service Principal with a Client Secret to authenticate. 

``` shell
az login
az account set -s <subscription_id>
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your-subscription-id>"

export ARM_SUBSCRIPTION_ID=<subscription-id>
export ARM_CLIENT_ID=<app-id>
export ARM_CLIENT_SECRET=<password>
export ARM_TENANT_ID=<tenant-id>

terraform init
terraform validate
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"

```

### TF with remote state on Azure

``` shell
terraform init \
      -backend-config="storage_account_name=<remote storage acc name>" \
      -backend-config="container_name=<remote container name>" \
      -backend-config="key=<BLOB FILE NAME>" \
      -backend-config="access_key=<storage access key>"
```

### Github Actions config
- One environment named dev
- Set up environment secret variables named ARM_CLIENT_ID, ARM_CLIENT_SECRET,ARM_TENANT_ID,ARM_SUBSCRIPTION_ID
- Setup a secret named AZURE_RBAC_CREDENTIALS to enabled github to perform deployments on the resource group - https://github.com/marketplace/actions/azure-functions-action#using-azure-service-principal-for-rbac-as-deployment-credential

### Testing after deployment
The API sits behind an Azure Front Door. AFD is not deployed to save costs. AFD only allows requests those are compliant with RFC standards.

``` shell
curl -d "" -X POST https://aa-eun-dev-availableapi-afd.azurefd.net/api/CreateTimestamp
```

### API Documentation
API documention is exposed as swagger at https://aa-eun-dev-availableapi-afd.azurefd.net/api/swagger/ui
