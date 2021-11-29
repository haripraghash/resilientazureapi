locals {
  cosmos-account-name = "${var.company_name}-${var.short_region}-${var.env}-${var.project_name}-cosmos"
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

resource "azurerm_cosmosdb_account" "cosmos_account" {
  name                = local.cosmos-account-name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  geo_location {
    location          = data.azurerm_resource_group.resource_group.location
    failover_priority = 0

    #Commenting out availability zone feature. My tenant has capacity problems
    # and creating cosmos with AZ resiliancy is failing.
    #zone_redundant    = true
  }

  consistency_policy {
    consistency_level = "Session"

  }
}

resource "azurerm_monitor_diagnostic_setting" "cosmos_diagnostics" {
  name                       = "${var.env}-cosmos-diagnostic-settings"
  target_resource_id         = azurerm_cosmosdb_account.cosmos_account.id
  log_analytics_workspace_id = var.la_workspace_resource_id

  log {
    category = "PartitionKeyStatistics"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmos_sql_db" {
  name                = "timestamps"
  resource_group_name = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name

  autoscale_settings {
    max_throughput = var.autoscale_max_throughput
  }
}

resource "azurerm_cosmosdb_sql_container" "cosmos_sql_container" {
  name                  = "timestamp-data"
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  account_name          = azurerm_cosmosdb_account.cosmos_account.name
  database_name         = azurerm_cosmosdb_sql_database.cosmos_sql_db.name
  partition_key_path    = "/id"
  partition_key_version = 1

  indexing_policy {
    indexing_mode = "Consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }
}
