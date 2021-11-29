locals {
  key-vault-name = "${var.company_name}${var.short_region}${var.env}${var.project_name}kv"
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key-vault" {
  name                       = local.key-vault-name
  location                   = data.azurerm_resource_group.resource_group.location
  resource_group_name        = data.azurerm_resource_group.resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key-vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
}

resource "azurerm_key_vault_access_policy" "policy" {
  for_each                = var.policies
  key_vault_id            = azurerm_key_vault.key-vault.id
  tenant_id               = lookup(each.value, "tenant_id")
  object_id               = lookup(each.value, "object_id")
  key_permissions         = lookup(each.value, "key_permissions")
  secret_permissions      = lookup(each.value, "secret_permissions")
  certificate_permissions = lookup(each.value, "certificate_permissions")
  storage_permissions     = lookup(each.value, "storage_permissions")
}

resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  key_vault_id = azurerm_key_vault.key-vault.id
  name         = each.key
  value        = lookup(each.value, "value")
  depends_on = [
    azurerm_key_vault.key-vault,
    azurerm_key_vault_access_policy.default_policy,
  ]
}