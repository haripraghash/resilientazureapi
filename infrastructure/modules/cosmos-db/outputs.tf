output "cosmos_account_key" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_key
}

output "cosmos_account_endpoint" {
  value = azurerm_cosmosdb_account.cosmos_account.endpoint
}
