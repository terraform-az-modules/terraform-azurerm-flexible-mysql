##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "flexible-mysql_server_id" {
  value       = module.flexible-mysql.mysql_flexible_server_id
  description = "The ID of the MySQL Flexible Server."
}

output "flexible-mysql_server_name" {
  value       = module.flexible-mysql.mysql_flexible_server_name
  description = "The Name of the MySQL Flexible Server."
}

