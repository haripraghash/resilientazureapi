locals {
  app-service-plan-name = "${var.company_name}-${var.short_region}-${var.env}-${var.project_name}-asp"
  function-app-name     = "${var.company_name}-${var.short_region}-${var.env}-${var.project_name}-function"
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}
resource "azurerm_app_service_plan" "app-service-plan" {
  name                = local.app-service-plan-name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  kind                = "elastic"
  reserved            = true
  zone_redundant      = true
  maximum_elastic_worker_count = 10
  sku {
    tier     = "Premium"
    size     = "EP1"
    capacity = 3
  }
}

resource "azurerm_function_app" "function-app" {
  name                       = local.function-app-name
  location                   = data.azurerm_resource_group.resource_group.location
  resource_group_name        = data.azurerm_resource_group.resource_group.name
  app_service_plan_id        = azurerm_app_service_plan.app-service-plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_access_key
  os_type                    = "linux"
  version                    = "~4"
  https_only = true 
  site_config {
    app_scale_limit = 10
    dotnet_framework_version = "v6.0"
    elastic_instance_minimum = 3
    http2_enabled = true
    runtime_scale_monitoring_enabled = true
    use_32_bit_worker_process = false
    pre_warmed_instance_count = 1
  }

  identity {
    type = "SystemAssigned"
  }
}