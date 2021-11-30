locals {
  secrets = {
    cosmos-endpoint = {
      value = module.cosmos_account.cosmos_account_endpoint
    }
    cosmos-connectiontionstring = {
      value = module.cosmos_account.cosmos_account_key
    }
  }

  access_policies = {
    functionapp = {
      tenant_id               = module.function-app.function_app_identity.0.tenant_id
      object_id               = module.function-app.function_app_identity.0.principal_id
      secret_permissions      = ["Get", "Set", "List"]
      storage_permissions     = []
      certificate_permissions = []
      key_permissions         = []
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

}

module "key-vault" {
  source              = "./modules/keyvault"
  short_region        = var.short_region
  resource_group_name = var.resource_group_name
  company_name        = var.company_name
  project_name        = var.project_name
  env                 = var.env
  secrets             = local.secrets
  policies            = local.access_policies
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
  app_insights_key    = module.app_insights.instrumentation_key
  keyvault_name       = module.key-vault.key-vault-name
}

module "storage-account" {
  source              = "./modules/storage"
  short_region        = var.short_region
  resource_group_name = var.resource_group_name
  company_name        = var.company_name
  project_name        = var.project_name
  env                 = var.env
}

module "front-door" {
  source              = "./modules/front-door"
  short_region        = var.short_region
  resource_group_name = var.resource_group_name
  company_name        = var.company_name
  project_name        = var.project_name
  env                 = var.env
  function_app_name   = module.function-app.function_app_name
}