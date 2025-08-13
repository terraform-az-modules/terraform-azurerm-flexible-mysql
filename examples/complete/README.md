<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.38.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flexible-mysql"></a> [flexible-mysql](#module\_flexible-mysql) | ../../ | n/a |
| <a name="module_log-analytics"></a> [log-analytics](#module\_log-analytics) | terraform-az-modules/log-analytics/azure | 1.0.0 |
| <a name="module_private_dns"></a> [private\_dns](#module\_private\_dns) | terraform-az-modules/private-dns/azure | 1.0.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-az-modules/resource-group/azure | 1.0.0 |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | terraform-az-modules/subnet/azure | 1.0.0 |
| <a name="module_vault"></a> [vault](#module\_vault) | terraform-az-modules/key-vault/azure | 1.0.0 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | terraform-az-modules/vnet/azure | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone_id_keyvault"></a> [dns\_zone\_id\_keyvault](#output\_dns\_zone\_id\_keyvault) | The ID of dns zone. |
| <a name="output_dns_zone_name_keyvault"></a> [dns\_zone\_name\_keyvault](#output\_dns\_zone\_name\_keyvault) | The name of dns zone. |
| <a name="output_flexible-mysql_server_id"></a> [flexible-mysql\_server\_id](#output\_flexible-mysql\_server\_id) | The ID of the MySQL Flexible Server. |
| <a name="output_flexible-mysql_server_name"></a> [flexible-mysql\_server\_name](#output\_flexible-mysql\_server\_name) | The Name of the MySQL Flexible Server. |
<!-- END_TF_DOCS -->
