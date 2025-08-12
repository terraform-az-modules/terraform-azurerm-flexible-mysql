variable "name" {
  description = "Application name"
  type        = string
  default     = "app"
}

variable "environment" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
  default     = "test"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "test-rg"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "centralindia"
}

variable "virtual_network_id" {
  description = "ID of the Virtual Network"
  type        = string
  default     = "/subscriptions/---------------<vnet_id>---------------"
}

variable "delegated_subnet_id" {
  description = "Delegated Subnet ID for MySQL Flexible Server"
  type        = string
  default     = "/subscriptions/---------------<delegated_subnet_id>---------------"
}

variable "mysql_version" {
  description = "MySQL server version"
  type        = string
  default     = "8.0.21"
}

variable "private_dns" {
  description = "Enable or disable Private DNS"
  type        = bool
  default     = true
}

variable "zone" {
  description = "Availability zone for MySQL"
  type        = string
  default     = "1"
}

variable "admin_username" {
  description = "Administrator username for MySQL"
  type        = string
  default     = "mysqlusername"
  sensitive   = true
}

variable "admin_password" {
  description = "Administrator password for MySQL"
  type        = string
  default     = "ba5yatgfgfhdsv6A3ns2lu4gqzzc"
  sensitive   = true
}

variable "sku_name" {
  description = "SKU name for MySQL Flexible Server"
  type        = string
  default     = "GP_Standard_D8ds_v4"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "maindb"
}

variable "charset" {
  description = "Database character set"
  type        = string
  default     = "utf8mb3"
}

variable "collation" {
  description = "Database collation"
  type        = string
  default     = "utf8mb3_unicode_ci"
}

variable "auto_grow_enabled" {
  description = "Enable auto grow for storage"
  type        = bool
  default     = true
}

variable "iops" {
  description = "Provisioned IOPS for MySQL"
  type        = number
  default     = 360
}

variable "size_gb" {
  description = "Storage size in GB"
  type        = number
  default     = 20
}

variable "server_configuration_names" {
  description = "List of MySQL server configuration names"
  type        = list(string)
  default     = ["interactive_timeout", "audit_log_enabled"]
}

variable "values" {
  description = "List of values corresponding to server_configuration_names"
  type        = list(string)
  default     = ["600", "ON"]
}
