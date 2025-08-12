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

output "dns_zone_id_keyvault" {
  value       = module.private_dns.private_dns_zone_ids.key_vault
  description = "The ID of dns zone."
}

output "dns_zone_name_keyvault" {
  value       = module.private_dns.private_dns_zone_names.key_vault
  description = "The name of dns zone."
}

