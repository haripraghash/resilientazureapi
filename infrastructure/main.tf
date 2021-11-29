locals {
  secrets = {
    cosmos-endpoint = {
      value = module.cosmos_account.cosmos_account_endpoint
    }
  }
}
data "azurerm_log_analytics_workspace" "la_workspace" {
  name                = var.la_workspace_name
  resource_group_name = var.la_resource_group_name
}

module "app_insights" {
  source                   = "./modules/app-insights"
  short_region             = var.short_region
  resource_group_name      = var.resource_group_name
  company_name             = var.company_name
  project_name             = var.project_name
  env                      = var.env
  la_workspace_resource_id = data.azurerm_log_analytics_workspace.la_workspace.id

}

module "cosmos_account" {
  source                   = "./modules/cosmos-db"
  short_region             = var.short_region
  resource_group_name      = var.resource_group_name
  company_name             = var.company_name
  project_name             = var.project_name
  env                      = var.env
  autoscale_max_throughput = var.autoscale_max_throughput
  la_workspace_resource_id = data.azurerm_log_analytics_workspace.la_workspace.id

}

module "key-vault" {
  source              = "./modules/keyvault"
  short_region        = var.short_region
  resource_group_name = var.resource_group_name
  company_name        = var.company_name
  project_name        = var.project_name
  env                 = var.env
  secrets             = local.secrets
}

module "function-app" {
  source              = "./modules/functionapp"
  short_region        = var.short_region
  resource_group_name = var.resource_group_name
  company_name        = var.company_name
  project_name        = var.project_name
  env                 = var.env
  storage_name        = module.storage-account.storage_account_name
  storage_access_key  = module.storage-account.storage_primary_key
}

module "storage-account" {
  source              = "./modules/storage"
  short_region        = var.short_region
  resource_group_name = var.resource_group_name
  company_name        = var.company_name
  project_name        = var.project_name
  env                 = var.env
}