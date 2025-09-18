##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------

variable "custom_name" {
  type        = string
  default     = null
  description = "Override the default naming convention."
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls placement of the resource type keyword (e.g., "vnet", "ddospp") in resource names.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

Maintains naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------

variable "name" {
  type        = string
  default     = null
  description = "Name label (e.g., 'app' or 'cluster')."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment, such as 'prod', 'dev', or 'staging'."
}

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Azure Region where the resource will be created. Changing this forces resource replacement."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "'ManagedBy' tag value, e.g., 'terraform-az-modules'."
}

variable "label_order" {
  type        = list(string)
  default     = ["name", "environment", "location"]
  description = "Order of labels for constructing resource names or tags."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azure-vnet"
  description = "Module source repository URL."

  validation {
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid HTTPS Git repository URL."
  }
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies infrastructure deployment mode."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Additional tags to apply to resources."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to disable resource creation by this module."
}

# variable "existing_private_dns_zone" {
#   type        = bool
#   default     = false
#   description = "Set to true if using an existing private DNS zone."
# }

# variable "registration_enabled" {
#   type        = bool
#   default     = false
#   description = "Enable auto-registration of VM records in the Private DNS zone."
# }

##-----------------------------------------------------------------------------
## MySQL Flexible Server Variables
##-----------------------------------------------------------------------------

variable "enable_special_char" {
  type        = bool
  default     = false
  description = "To Include special characters in the result."
}

variable "admin_username" {
  type        = string
  default     = "mysqlusername"
  description = "The administrator username for the MySQL server."
}

variable "admin_password" {
  type        = string
  default     = "ba5yatgfgfhdsv6A3ns2lu4gqzzc"
  sensitive   = true
  description = "The administrator password for the MySQL server (sensitive value)."
}

variable "admin_password_length" {
  type        = number
  default     = 16
  description = "Length of the randomly generated admin password, if not provided."
}

variable "backup_retention_days" {
  type        = number
  default     = 7
  description = "Backup retention days for MySQL Flexible Server (1-35)."
}

variable "delegated_subnet_id" {
  type        = string
  default     = ""
  description = "Resource ID of the delegated subnet."
}

variable "sku_name" {
  type        = string
  default     = "GP_Standard_D8ds_v4"
  description = "The SKU name defining the size and performance tier of the MySQL server."
}

variable "create_mode" {
  type        = string
  default     = "Default"
  description = "Creation mode (Default, Replica, GeoRestore, PointInTimeRestore)."
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  default     = false
  description = "Enable geo redundant backups. Changing this triggers resource replacement."
}

variable "replication_role" {
  type        = string
  default     = null
  description = "Replication role for the MySQL Flexible Server (e.g., 'None')."
}

variable "mysql_version" {
  type        = string
  default     = "8.0.21"
  description = "The version of the MySQL server to deploy."
}

variable "zone" {
  type        = number
  default     = 1
  description = "Availability Zone for the server (1, 2, or 3)."
}

variable "point_in_time_restore_time_in_utc" {
  type        = string
  default     = null
  description = "Point in time to restore from when using 'PointInTimeRestore' mode."
}

variable "source_server_id" {
  type        = string
  default     = null
  description = "Source server ID for restore or replication modes."
}

# variable "virtual_network_id" {
#   type        = string
#   default     = ""
#   description = "Virtual network resource ID."
# }

# variable "private_dns" {
#   type        = bool
#   default     = false
#   description = "Enable private DNS integration."
# }

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group name where MySQL Flexible Server is deployed."
}

variable "existing_private_dns_zone_id" {
  type        = string
  default     = null
  description = "ID of the existing private DNS zone."
}

variable "auto_grow_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable automatic storage growth for the database."
}

variable "iops" {
  type        = number
  default     = 360
  description = "The number of Input/Output Operations Per Second (IOPS) provisioned for the storage."
}

variable "size_gb" {
  type        = string
  default     = "20"
  description = "The size of the MySQL server disk storage in gigabytes."
}

variable "server_configuration_names" {
  type        = list(string)
  default     = ["interactive_timeout", "audit_log_enabled", "audit_log_events"]
  description = "List of MySQL server configuration parameters to be set."
}

variable "values" {
  type        = list(string)
  default     = ["600", "ON", "CONNECTION,ADMIN,DDL,TABLE_ACCESS"]
  description = "Corresponding values for the server configuration parameters."
}

variable "db_name" {
  type        = string
  default     = "maindb"
  description = "The name of the default database to be created on the MySQL server."
}

variable "charset" {
  type        = string
  default     = "utf8mb3"
  description = "The character set to use by default on the MySQL database."
}

variable "collation" {
  type        = string
  default     = "utf8mb3_unicode_ci"
  description = "The collation setting for the MySQL database."
}

variable "high_availability" {
  type = object({
    mode                      = string
    standby_availability_zone = optional(number)
  })
  default     = null
  description = "High availability configuration object. Set to null to disable."
}

variable "enable_diagnostic" {
  type        = bool
  default     = true
  description = "Enable diagnostic settings creation."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "Log Analytics workspace ID where logs will be sent."
}

variable "metric_enabled" {
  type        = bool
  default     = true
  description = "Enable metrics diagnostics for MySQL Flexible Server."
}

variable "log_category" {
  type        = list(string)
  default     = ["MySqlAuditLogs"]
  description = "List of log categories to collect (e.g., 'MySqlSlowLogs', 'MySqlAuditLogs')."
}

variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "Destination type for logs; 'AzureDiagnostics' or 'Dedicated'."
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "Storage Account ID for diagnostic settings destination."
}

variable "eventhub_name" {
  type        = string
  default     = null
  description = "EventHub name for diagnostic settings destination."
}

variable "eventhub_authorization_rule_id" {
  type        = string
  default     = null
  description = "EventHub authorization rule ID for diagnostic settings destination."
}

variable "cmk_enabled" {
  type        = bool
  default     = false
  description = "Enable Customer Managed Key (CMK) for encryption."
}

variable "key_vault_id" {
  type        = string
  default     = null
  description = "Key Vault resource ID where the CMK is stored."
}

variable "cmk_key_type" {
  type        = string
  default     = "RSA-HSM"
  description = "Key type for CMK encryption ('RSA' by default)."
}

variable "cmk_key_size" {
  type        = number
  default     = 2048
  description = "Key size for CMK encryption."
}

variable "expiration_date" {
  type        = string
  default     = "2025-12-31T23:59:59Z"
  description = "Expiration date for the Key Vault key (RFC3339 format: YYYY-MM-DDThh:mm:ssZ)"
}

variable "key_vault_with_rbac" {
  type        = bool
  default     = false
  description = "Enable RBAC permissions on the Key Vault."
}

variable "custom_tags" {
  type        = map(string)
  default     = null
  description = "Map of custom tags to apply to resources."
}

variable "identity_type" {
  type        = string
  default     = null
  description = "Managed identity type to assign (e.g., 'SystemAssigned', 'UserAssigned')."
}

variable "user_assigned_identity_ids" {
  type        = list(string)
  default     = []
  description = "List of User-Assigned Managed Identity IDs."
}

variable "entra_authentication" {
  type = object({
    user_assigned_identity_id = optional(string, null)
    login                     = optional(string, null)
    object_id                 = optional(string, null)
  })
  default     = {}
  description = "Azure Entra authentication configuration for MySQL Flexible Server."
}

# variable "mysql_server_name" {
#   type        = string
#   default     = null
#   description = "Name of the MySQL Flexible Server."
# }

variable "key_opts" {
  type        = list(string)
  default     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
  description = "List of permitted key operations for CMK."
}

variable "key_permissions" {
  type        = list(string)
  default     = ["Get", "WrapKey", "UnwrapKey", "List"]
  description = "List of key permissions granted for CMK."
}

variable "role_definition_name" {
  type        = string
  default     = "Key Vault Crypto Service Encryption User"
  description = "Name of the Role Definition assigned for Key Vault crypto operations."
}
