output "storage_primary_key" {
  value = azurerm_storage_account.storage-account.primary_access_key
}

output "storage_account_name" {
  value = azurerm_storage_account.storage-account.name
}

