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
| [azurerm_app_service_plan.app-service-plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_function_app.function-app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_key"></a> [app\_insights\_key](#input\_app\_insights\_key) | App insights key. | `string` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Short company name used as resource naming prefix. | `string` | `"AA"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment into which this app is deployed into. | `string` | n/a | yes |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | KV resource name. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project/platform that this resource is intended for. | `string` | `"availableapi"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group the resource will be part of. | `string` | n/a | yes |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | Short azure region name - eun,euw etc. | `string` | n/a | yes |
| <a name="input_storage_access_key"></a> [storage\_access\_key](#input\_storage\_access\_key) | Storage primary access key. | `string` | n/a | yes |
| <a name="input_storage_name"></a> [storage\_name](#input\_storage\_name) | The name of the storage account. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_app_identity"></a> [function\_app\_identity](#output\_function\_app\_identity) | n/a |
| <a name="output_function_app_name"></a> [function\_app\_name](#output\_function\_app\_name) | n/a |
<!-- END_TF_DOCS -->