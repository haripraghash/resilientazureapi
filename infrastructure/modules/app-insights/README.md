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
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Short company name used as resource naming prefix. | `string` | `"aa"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment into which this app is deployed into. | `string` | n/a | yes |
| <a name="input_la_workspace_resource_id"></a> [la\_workspace\_resource\_id](#input\_la\_workspace\_resource\_id) | Resource id of the LA workspace | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project/platform that this resource is intended for. | `string` | `"availableapi"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group the resource will be part of. | `string` | n/a | yes |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | Short azure region name - eun,euw etc. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | n/a |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | n/a |
<!-- END_TF_DOCS -->