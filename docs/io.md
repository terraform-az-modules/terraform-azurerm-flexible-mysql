## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_password | Password for the administrator login user. | `string` | `null` | no |
| admin\_password\_length | Length of the randomly generated admin password, if not provided. | `number` | `16` | no |
| admin\_username | Administrator login name for the MySQL Flexible Server. | `string` | `null` | no |
| auto\_grow\_enabled | Enable storage auto-grow (default disabled). | `bool` | `true` | no |
| backup\_retention\_days | Backup retention days for MySQL Flexible Server (1-35). | `number` | `7` | no |
| charset | Charset for the MySQL database. | `string` | `"utf8mb3"` | no |
| cmk\_enabled | Enable Customer Managed Key (CMK) for encryption. | `bool` | `false` | no |
| cmk\_key\_size | Key size for CMK encryption. | `number` | `2048` | no |
| cmk\_key\_type | Key type for CMK encryption ('RSA' by default). | `string` | `"RSA"` | no |
| collation | Collation for the MySQL database. | `string` | `"utf8mb3_unicode_ci"` | no |
| create\_mode | Creation mode (Default, Replica, GeoRestore, PointInTimeRestore). | `string` | `"Default"` | no |
| custom\_name | Override the default naming convention. | `string` | `null` | no |
| db\_name | MySQL Database name; must be a valid identifier. | `string` | `""` | no |
| delegated\_subnet\_id | Resource ID of the delegated subnet. | `string` | `null` | no |
| deployment\_mode | Specifies infrastructure deployment mode. | `string` | `"terraform"` | no |
| enable\_diagnostic | Enable diagnostic settings creation. | `bool` | `true` | no |
| enable\_firewall | Enable firewall rule creation | `bool` | `false` | no |
| enable\_private\_endpoint | Manages a Private Endpoint to Azure database for MySql | `bool` | `false` | no |
| enabled | Set to false to disable resource creation by this module. | `bool` | `true` | no |
| entra\_authentication | Azure Entra authentication configuration for MySQL Flexible Server. | <pre>object({<br>    login     = optional(string, null)<br>    object_id = optional(string, null)<br>  })</pre> | `{}` | no |
| environment | Deployment environment, such as 'prod', 'dev', or 'staging'. | `string` | `null` | no |
| eventhub\_authorization\_rule\_id | EventHub authorization rule ID for diagnostic settings destination. | `string` | `null` | no |
| eventhub\_name | EventHub name for diagnostic settings destination. | `string` | `null` | no |
| expiration\_date | Expiration UTC datetime (Y-m-d'T'H:M:S'Z') | `string` | `null` | no |
| extra\_tags | Additional tags to apply to resources. | `map(string)` | `null` | no |
| firewall\_rules | Map of firewall rule names to lists of IP ranges | <pre>map(list(object({<br>    start_ip = string<br>    end_ip   = string<br>  })))</pre> | `{}` | no |
| geo\_redundant\_backup\_enabled | Enable geo redundant backups. Changing this triggers resource replacement. | `bool` | `false` | no |
| high\_availability | High availability configuration object. Set to null to disable. | <pre>object({<br>    mode                      = string<br>    standby_availability_zone = optional(number)<br>  })</pre> | `null` | no |
| identity\_type | Managed identity type to assign (e.g., 'SystemAssigned', 'UserAssigned'). | `string` | `null` | no |
| iops | Storage IOPS; valid range 360 to 20000. | `number` | `360` | no |
| key\_opts | List of permitted key operations for CMK. | `list(string)` | <pre>[<br>  "encrypt",<br>  "decrypt",<br>  "sign",<br>  "verify",<br>  "wrapKey",<br>  "unwrapKey"<br>]</pre> | no |
| key\_permissions | List of key permissions granted for CMK. | `list(string)` | <pre>[<br>  "Get",<br>  "WrapKey",<br>  "UnwrapKey",<br>  "List"<br>]</pre> | no |
| key\_vault\_id | Key Vault resource ID where the CMK is stored. | `string` | `null` | no |
| key\_vault\_with\_rbac | Enable RBAC permissions on the Key Vault. | `bool` | `false` | no |
| label\_order | Order of labels for constructing resource names or tags. | `list(string)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | Azure Region where the resource will be created. Changing this forces resource replacement. | `string` | `"centralindia"` | no |
| log\_analytics\_destination\_type | Destination type for logs; 'AzureDiagnostics' or 'Dedicated'. | `string` | `"AzureDiagnostics"` | no |
| log\_analytics\_workspace\_id | Log Analytics workspace ID where logs will be sent. | `string` | `null` | no |
| log\_category | List of log categories to collect (e.g., 'MySqlSlowLogs', 'MySqlAuditLogs'). | `list(string)` | <pre>[<br>  "MySqlAuditLogs"<br>]</pre> | no |
| managedby | 'ManagedBy' tag value, e.g., 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| metric\_enabled | Enable metrics diagnostics for MySQL Flexible Server. | `bool` | `true` | no |
| min\_lower | Minimum number of lowercase letters in the generated password. | `number` | `2` | no |
| min\_numeric | Minimum number of numeric characters in the generated password. | `number` | `4` | no |
| min\_upper | Minimum number of uppercase letters in the generated password. | `number` | `4` | no |
| mysql\_version | MySQL version; valid values are '5.7' or '8.0.21'. Changing forces replacement. | `string` | `"5.7"` | no |
| name | Name label (e.g., 'app' or 'cluster'). | `string` | `null` | no |
| point\_in\_time\_restore\_time\_in\_utc | Point in time to restore from when using 'PointInTimeRestore' mode. | `string` | `null` | no |
| private\_endpoint\_dns\_zone\_id | The ID of the Private DNS Zone to associate with the MySql Flexible Server,when private endpoint is enabled. | `string` | `null` | no |
| private\_endpoint\_subnet\_id | The subnet ID where the private endpoint will be deployed | `string` | `null` | no |
| public\_network\_access | Specifies the level of public network access allowed for the resource. | `string` | `"Enabled"` | no |
| replication\_role | Replication role for the MySQL Flexible Server (e.g., 'None'). | `string` | `null` | no |
| repository | Module source repository URL. | `string` | `"https://github.com/terraform-az-modules/terraform-azure-flexible-mysql"` | no |
| resource\_group\_name | Resource group name where MySQL Flexible Server is deployed. | `string` | `"rg-flexible-mysql"` | no |
| resource\_position\_prefix | Controls placement of the resource type keyword (e.g., "vnet", "ddospp") in resource names.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>Maintains naming consistency based on organizational preferences. | `bool` | `true` | no |
| role\_definition\_name | Name of the Role Definition assigned for Key Vault crypto operations. | `string` | `"Key Vault Crypto Service Encryption User"` | no |
| server\_configuration\_names | List of MySQL server configuration option names. | `list(string)` | `[]` | no |
| size\_gb | Maximum storage size in GB; valid range 20 to 16,384. | `number` | `20` | no |
| sku\_name | SKU name for the MySQL Flexible Server. | `string` | `"GP_Standard_D8ds_v4"` | no |
| source\_server\_id | Source server ID for restore or replication modes. | `string` | `null` | no |
| special | Whether to include special characters in the generated password. | `bool` | `false` | no |
| storage\_account\_id | Storage Account ID for diagnostic settings destination. | `string` | `null` | no |
| user\_assigned\_identity\_ids | List of User-Assigned Managed Identity IDs. | `list(string)` | `[]` | no |
| values | List of values corresponding to server configuration names. | `list(string)` | <pre>[<br>  "600",<br>  "ON",<br>  "CONNECTION,ADMIN,DDL,TABLE_ACCESS"<br>]</pre> | no |
| vnet\_integration\_private\_dns\_zone\_id | The ID of the Private DNS Zone to associate with the MySql Flexible Server. | `string` | `null` | no |
| zone | Availability Zone for the server (1, 2, or 3). | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_mysql\_flexible\_database\_id | The id of azurerm\_mysql\_flexible\_database. |
| azurerm\_mysql\_flexible\_server\_active\_directory\_administrator\_id | The id of azurerm\_mysql\_flexible\_server\_active\_directory\_administrator |
| azurerm\_mysql\_flexible\_server\_configuration\_id | The ID of the MySQL Flexible Server Configuration. |
| mysql\_flexible\_server\_id | The ID of the MySQL Flexible Server. |
| mysql\_flexible\_server\_name | The Name of the MySQL Flexible Server. |

