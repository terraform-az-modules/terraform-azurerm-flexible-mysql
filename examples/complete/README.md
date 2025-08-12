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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The administrator password for the MySQL server (sensitive value). | `string` | `"ba5yatgfgfhdsv6A3ns2lu4gqzzc"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The administrator username for the MySQL server. | `string` | `"mysqlusername"` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Enable or disable automatic storage growth for the database. | `bool` | `true` | no |
| <a name="input_charset"></a> [charset](#input\_charset) | The character set to use by default on the MySQL database. | `string` | `"utf8mb3"` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | The collation setting for the MySQL database. | `string` | `"utf8mb3_unicode_ci"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the default database to be created on the MySQL server. | `string` | `"maindb"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The number of Input/Output Operations Per Second (IOPS) provisioned for the storage. | `number` | `360` | no |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | The version of the MySQL server to deploy. | `string` | `"8.0.21"` | no |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Enable or disable private DNS for the MySQL server. | `bool` | `true` | no |
| <a name="input_server_configuration_names"></a> [server\_configuration\_names](#input\_server\_configuration\_names) | List of MySQL server configuration parameters to be set. | `list(string)` | <pre>[<br>  "interactive_timeout",<br>  "audit_log_enabled",<br>  "audit_log_events"<br>]</pre> | no |
| <a name="input_size_gb"></a> [size\_gb](#input\_size\_gb) | The size of the MySQL server disk storage in gigabytes. | `string` | `"20"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name defining the size and performance tier of the MySQL server. | `string` | `"GP_Standard_D8ds_v4"` | no |
| <a name="input_values"></a> [values](#input\_values) | Corresponding values for the server configuration parameters. | `list(string)` | <pre>[<br>  "600",<br>  "ON",<br>  "CONNECTION,ADMIN,DDL,TABLE_ACCESS"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone where the MySQL server will be deployed. | `string` | `"1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
