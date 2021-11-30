<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_insights"></a> [app\_insights](#module\_app\_insights) | ./modules/app-insights | n/a |
| <a name="module_cosmos_account"></a> [cosmos\_account](#module\_cosmos\_account) | ./modules/cosmos-db | n/a |
| <a name="module_function-app"></a> [function-app](#module\_function-app) | ./modules/functionapp | n/a |
| <a name="module_key-vault"></a> [key-vault](#module\_key-vault) | ./modules/keyvault | n/a |
| <a name="module_storage-account"></a> [storage-account](#module\_storage-account) | ./modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.la_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscale_max_throughput"></a> [autoscale\_max\_throughput](#input\_autoscale\_max\_throughput) | Max throughput for auto scale of cosmos db. | `number` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Short company name used as resource naming prefix | `string` | `"AA"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment into which this app is deployed into | `string` | n/a | yes |
| <a name="input_la_resource_group_name"></a> [la\_resource\_group\_name](#input\_la\_resource\_group\_name) | Name of the ersource group hosting LA Workspace | `string` | n/a | yes |
| <a name="input_la_workspace_name"></a> [la\_workspace\_name](#input\_la\_workspace\_name) | Name of the LA workspace. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project/platform that this resource is intended for. | `string` | `"availableapi"` | no |
| <a name="input_region"></a> [region](#input\_region) | The azure region the resource will be deployed into. | `string` | `"northeurope"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | Short azure region name - eun,euw etc. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->