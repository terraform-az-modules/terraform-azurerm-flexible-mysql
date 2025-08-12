##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------
resource "azurerm_role_assignment" "primary_cmk_role_assignment" {
  count                = var.key_vault_with_rbac && var.cmk_enabled ? 1 : 0
  principal_id         = azurerm_user_assigned_identity.primary_cmk_umi[0].principal_id
  role_definition_name = var.role_definition_name
  scope                = var.key_vault_id
}

resource "azurerm_key_vault_access_policy" "primary_cmk_access_policy" {
  count           = !var.key_vault_with_rbac && var.cmk_enabled ? 1 : 0
  key_vault_id    = var.key_vault_id
  tenant_id       = data.azurerm_client_config.current.tenant_id
  object_id       = azurerm_user_assigned_identity.primary_cmk_umi[0].principal_id
  key_permissions = var.key_permissions
}

resource "azurerm_user_assigned_identity" "geo_cmk_umi" {
  count               = var.geo_redundant_backup_enabled && var.cmk_enabled ? 1 : 0
  name                = format("%s-cmk-geo-identity", module.labels.id)
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "geo_cmk_role_assignment" {
  count                = var.key_vault_with_rbac && var.cmk_enabled && var.geo_redundant_backup_enabled ? 1 : 0
  principal_id         = azurerm_user_assigned_identity.geo_cmk_umi[0].principal_id
  role_definition_name = var.role_definition_name
  scope                = var.key_vault_id
}

resource "azurerm_key_vault_access_policy" "geo_cmk_access_policy" {
  count           = !var.key_vault_with_rbac && var.cmk_enabled && var.geo_redundant_backup_enabled ? 1 : 0
  key_vault_id    = var.key_vault_id
  tenant_id       = data.azurerm_client_config.current.tenant_id
  object_id       = azurerm_user_assigned_identity.geo_cmk_umi[0].principal_id
  key_permissions = var.key_permissions
}