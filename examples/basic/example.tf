provider "azurerm" {
  features {}
}
##-----------------------------------------------------------------------------
## Flexible Mysql server module call.
##-----------------------------------------------------------------------------
module "flexible-mysql" {
  source              = "../../"
  name                = var.name
  environment         = var.environment
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  delegated_subnet_id = var.delegated_subnet_id
  mysql_version       = var.mysql_version
  private_dns         = var.private_dns
  zone                = var.zone
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  sku_name            = var.sku_name
  db_name             = var.db_name
  charset             = var.charset
  collation           = var.collation
  auto_grow_enabled   = var.auto_grow_enabled
  iops                = var.iops
  size_gb             = var.size_gb
  ## azurerm_mysql_flexible_server_configuration
  server_configuration_names = var.server_configuration_names
  values                     = var.values
}
