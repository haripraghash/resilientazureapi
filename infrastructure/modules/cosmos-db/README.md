<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_container.cosmos_sql_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_database.cosmos_sql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscale_max_throughput"></a> [autoscale\_max\_throughput](#input\_autoscale\_max\_throughput) | Max throughput for auto scale of cosmos db. | `number` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Short company name used as resource naming prefix. | `string` | `"AA"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment into which this app is deployed into. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project/platform that this resource is intended for. | `string` | `"availableapi"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group the resource will be part of. | `string` | n/a | yes |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | Short azure region name - eun,euw etc. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmos_account_endpoint"></a> [cosmos\_account\_endpoint](#output\_cosmos\_account\_endpoint) | n/a |
| <a name="output_cosmos_account_key"></a> [cosmos\_account\_key](#output\_cosmos\_account\_key) | n/a |
<!-- END_TF_DOCS -->