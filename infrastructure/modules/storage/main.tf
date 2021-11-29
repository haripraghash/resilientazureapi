locals {
  storage-account-name = "${var.company_name}${var.short_region}${var.env}${var.project_name}stor"
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "storage-account" {
  name                      = local.storage-account-name
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  account_tier              = "Standard"
  account_replication_type  = "RAGZRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"


  tags = {
    env     = var.env
    project = var.project_name
  }
}
