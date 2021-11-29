locals {
  app_insights_name = "${var.company_name}-${var.short_region}-${var.env}-${var.project_name}-ai"
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

resource "azurerm_application_insights" "app_insights" {
  name                = local.app_insights_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = var.resource_group_name
  workspace_id        = var.la_workspace_resource_id
  application_type    = "web"
}
