<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.112.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flexible-mysql"></a> [flexible-mysql](#module\_flexible-mysql) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Administrator password for MySQL | `string` | `"ba5yatgfgfhdsv6A3ns2lu4gqzzc"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Administrator username for MySQL | `string` | `"mysqlusername"` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Enable auto grow for storage | `bool` | `true` | no |
| <a name="input_charset"></a> [charset](#input\_charset) | Database character set | `string` | `"utf8mb3"` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | Database collation | `string` | `"utf8mb3_unicode_ci"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | `"maindb"` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | Delegated Subnet ID for MySQL Flexible Server | `string` | `"/subscriptions/---------------<delegated_subnet_id>---------------"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g., dev, test, prod) | `string` | `"test"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | Provisioned IOPS for MySQL | `number` | `360` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"centralindia"` | no |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | MySQL server version | `string` | `"8.0.21"` | no |
| <a name="input_name"></a> [name](#input\_name) | Application name | `string` | `"app"` | no |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Enable or disable Private DNS | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"test-rg"` | no |
| <a name="input_server_configuration_names"></a> [server\_configuration\_names](#input\_server\_configuration\_names) | List of MySQL server configuration names | `list(string)` | <pre>[<br>  "interactive_timeout",<br>  "audit_log_enabled"<br>]</pre> | no |
| <a name="input_size_gb"></a> [size\_gb](#input\_size\_gb) | Storage size in GB | `number` | `20` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | SKU name for MySQL Flexible Server | `string` | `"GP_Standard_D8ds_v4"` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values corresponding to server\_configuration\_names | `list(string)` | <pre>[<br>  "600",<br>  "ON"<br>]</pre> | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | ID of the Virtual Network | `string` | `"/subscriptions/---------------<vnet_id>---------------"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Availability zone for MySQL | `string` | `"1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_flexible-mysql_server_id"></a> [flexible-mysql\_server\_id](#output\_flexible-mysql\_server\_id) | The ID of the MySQL Flexible Server. |
<!-- END_TF_DOCS -->