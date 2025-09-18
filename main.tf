data "azurerm_client_config" "current" {}
##-----------------------------------------------------------------------------
## Tagging Module – Applies standard tags to all resources
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azure"
  version         = "1.0.0"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##-----------------------------------------------------------------------------
## Random Password Resource.
## Will be passed as admin password of mysql server when admin password is not passed manually as variable.
##-----------------------------------------------------------------------------
resource "random_password" "main" {
  count       = var.admin_password == null ? 1 : 0
  length      = var.admin_password_length
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = var.enable_special_char
}

##-----------------------------------------------------------------------------
## Below resource will create flexible MySQL server in Azure environment.
##-----------------------------------------------------------------------------
resource "azurerm_mysql_flexible_server" "main" {
  count                             = var.enabled ? 1 : 0
  name                              = var.resource_position_prefix ? format("mysql-flexible-server-%s", local.name) : format("%s-mysql-flexible-server", local.name)
  resource_group_name               = var.resource_group_name
  location                          = var.location
  administrator_login               = var.admin_username
  administrator_password            = var.admin_password == null ? random_password.main[0].result : var.admin_password
  backup_retention_days             = var.backup_retention_days
  delegated_subnet_id               = var.delegated_subnet_id
  private_dns_zone_id               = var.existing_private_dns_zone_id
  sku_name                          = var.sku_name
  create_mode                       = var.create_mode
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = var.create_mode == "PointInTimeRestore" ? var.point_in_time_restore_time_in_utc : null
  replication_role                  = var.replication_role
  source_server_id                  = var.create_mode == "PointInTimeRestore" ? var.source_server_id : null

  storage {
    auto_grow_enabled = var.auto_grow_enabled
    iops              = var.iops
    size_gb           = var.size_gb
  }

  dynamic "high_availability" {
    for_each = toset(var.high_availability != null ? [var.high_availability] : [])
    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = lookup(high_availability.value, "standby_availability_zone", 1)
    }
  }

  dynamic "identity" {
    for_each = toset(var.identity_type != null ? [var.identity_type] : [])
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.user_assigned_identity_ids : []
    }
  }

  dynamic "identity" {
    for_each = var.cmk_enabled ? [true] : []
    content {
      type = "UserAssigned"
      identity_ids = flatten([
        [azurerm_user_assigned_identity.primary_cmk_umi[0].id],
        var.geo_redundant_backup_enabled ? [azurerm_user_assigned_identity.geo_cmk_umi[0].id] : []
      ])
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.cmk_enabled ? [true] : []
    content {
      key_vault_key_id                     = azurerm_key_vault_key.primary_cmk_key[0].id
      primary_user_assigned_identity_id    = azurerm_user_assigned_identity.primary_cmk_umi[0].id
      geo_backup_key_vault_key_id          = var.geo_redundant_backup_enabled ? azurerm_key_vault_key.geo_cmk_key[0].id : null
      geo_backup_user_assigned_identity_id = var.geo_redundant_backup_enabled ? azurerm_user_assigned_identity.geo_cmk_umi[0].id : null
    }
  }
  version = var.mysql_version
  zone    = var.zone
  tags    = var.custom_tags == null ? module.labels.tags : var.custom_tags
}

##-----------------------------------------------------------------------------
## Below resource will create MySQL server Active Directory administrator.
##-----------------------------------------------------------------------------
resource "azurerm_mysql_flexible_server_active_directory_administrator" "main" {
  count       = length(var.entra_authentication.object_id[*]) > 0 ? 1 : 0
  depends_on  = [azurerm_mysql_flexible_server.main]
  server_id   = join("", azurerm_mysql_flexible_server.main[*].id)
  identity_id = var.entra_authentication.user_assigned_identity_id
  login       = var.entra_authentication.login
  object_id   = var.entra_authentication.object_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}

##-----------------------------------------------------------------------------
## Below resource will create MySQL flexible database.
##-----------------------------------------------------------------------------
resource "azurerm_mysql_flexible_database" "main" {
  count               = var.enabled ? 1 : 0
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.main[0].name
  charset             = var.charset
  collation           = var.collation
  depends_on          = [azurerm_mysql_flexible_server_active_directory_administrator.main]
}

##-----------------------------------------------------------------------------
## Below resource will create flexible MySQL server configuration.
##-----------------------------------------------------------------------------
resource "azurerm_mysql_flexible_server_configuration" "main" {
  count               = var.enabled ? length(var.server_configuration_names) : 0
  name                = element(var.server_configuration_names, count.index)
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.main[0].name
  value               = element(var.values, count.index)
}

##-----------------------------------------------------------------------------
## Below resource will create diagnostic settings for MySQL flexible server.
##-----------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "mysql" {
  count                          = var.enabled && var.enable_diagnostic ? 1 : 0
  name                           = var.resource_position_prefix ? format("mysql-diagnostic-log-%s", local.name) : format("%s-mysql-diagnostic-log", local.name)
  target_resource_id             = azurerm_mysql_flexible_server.main[0].id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = var.log_category
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = enabled_metric.value
    }
  }
}

##-----------------------------------------------------------------------------
## Below resource will create user assigned identity for primary CMK.
##-----------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "primary_cmk_umi" {
  count               = var.cmk_enabled ? 1 : 0
  name                = var.resource_position_prefix ? format("cmk-primary-identity-%s", local.name) : format("%s-cmk-primary-identity", local.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = module.labels.tags
}

##-----------------------------------------------------------------------------
## Below resource will create primary Customer Managed Key (CMK) key vault key.
##-----------------------------------------------------------------------------
resource "azurerm_key_vault_key" "primary_cmk_key" {
  count           = var.cmk_enabled ? 1 : 0
  name            = var.resource_position_prefix ? format("cmk-key-%s", local.name) : format("%s-cmk-key", local.name)
  key_vault_id    = var.key_vault_id
  key_type        = var.cmk_key_type
  key_size        = var.cmk_key_size
  key_opts        = var.key_opts
  expiration_date = var.expiration_date
  tags            = module.labels.tags
}

##-----------------------------------------------------------------------------
## Below resource will create geo-redundant Customer Managed Key (CMK) key vault key.
##-----------------------------------------------------------------------------
resource "azurerm_key_vault_key" "geo_cmk_key" {
  count           = var.geo_redundant_backup_enabled && var.cmk_enabled ? 1 : 0
  name            = var.resource_position_prefix ? format("geo-cmk-key-%s", local.name) : format("%s-geo-cmk-key", local.name)
  key_vault_id    = var.key_vault_id
  key_type        = var.cmk_key_type
  key_size        = var.cmk_key_size
  key_opts        = var.key_opts
  expiration_date = var.expiration_date
  tags            = module.labels.tags
}
