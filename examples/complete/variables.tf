##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------
variable "mysql_version" {
  type        = string
  default     = "8.0.21"
  description = "The version of the MySQL server to deploy."
}

variable "private_dns" {
  type        = bool
  default     = true
  description = "Enable or disable private DNS for the MySQL server."
}

variable "zone" {
  type        = string
  default     = "1"
  description = "The availability zone where the MySQL server will be deployed."
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

variable "sku_name" {
  type        = string
  default     = "GP_Standard_D8ds_v4"
  description = "The SKU name defining the size and performance tier of the MySQL server."
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

variable "auto_grow_enabled" {
  type        = bool
  default     = true
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
