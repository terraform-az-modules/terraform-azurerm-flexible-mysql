output "mysql_flexible_server_id" {
  value       = try(azurerm_mysql_flexible_server.main[0].id, null)
  description = "The ID of the MySQL Flexible Server."
}

output "mysql_flexible_server_name" {
  value       = try(azurerm_mysql_flexible_server.main[0].fqdn, null)
  description = "The Name of the MySQL Flexible Server."
}

output "azurerm_mysql_flexible_server_configuration_id" {
  value       = try(azurerm_mysql_flexible_server_configuration.main[0].id, null)
  description = "The ID of the MySQL Flexible Server Configuration."
}

output "azurerm_mysql_flexible_database_id" {
  value       = try(azurerm_mysql_flexible_database.main[0].id, null)
  description = "The id of azurerm_mysql_flexible_database."
}

output "azurerm_mysql_flexible_server_active_directory_administrator_id" {
  value       = try(azurerm_mysql_flexible_server_active_directory_administrator.main[0].id, null)
  description = "The id of azurerm_mysql_flexible_server_active_directory_administrator"
}
