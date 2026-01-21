provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current_client_config" {}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "core"
  environment = "dev"
  location    = "centralindia"
  label_order = ["name", "environment", "location"]
}

# ------------------------------------------------------------------------------
# Virtual Network
# ------------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = "core"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

# ------------------------------------------------------------------------------
# Subnet
# ------------------------------------------------------------------------------
module "subnet" {
  source               = "terraform-az-modules/subnet/azurerm"
  version              = "1.0.1"
  environment          = "dev"
  label_order          = ["name", "environment", "location"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name
  subnets = [
    {
      name            = "subnet1"
      subnet_prefixes = ["10.0.1.0/24"]
      delegations = [
        {
          name = "delegation1"
          service_delegations = [
            {
              name    = "Microsoft.DBforMySQL/flexibleServers"
              actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
            }
          ]
        }
      ]
    },
    {
      name            = "subnet2"
      subnet_prefixes = ["10.0.2.0/24"]
    }
  ]
}

# ------------------------------------------------------------------------------
# Log Analytics
# ------------------------------------------------------------------------------
module "log-analytics" {
  source                      = "terraform-az-modules/log-analytics/azurerm"
  version                     = "1.0.2"
  name                        = "core"
  environment                 = "dev"
  label_order                 = ["name", "environment", "location"]
  log_analytics_workspace_sku = "PerGB2018"
  resource_group_name         = module.resource_group.resource_group_name
  location                    = module.resource_group.resource_group_location
  log_analytics_workspace_id  = module.log-analytics.workspace_id
}

# ------------------------------------------------------------------------------
# Key Vault
# ------------------------------------------------------------------------------
module "vault" {
  source                        = "terraform-az-modules/key-vault/azurerm"
  version                       = "1.0.1"
  name                          = "core"
  environment                   = "dev"
  label_order                   = ["name", "environment", "location"]
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.resource_group_location
  subnet_id                     = module.subnet.subnet_ids.subnet2
  public_network_access_enabled = true
  sku_name                      = "standard"
  private_dns_zone_ids          = module.private_dns.private_dns_zone_ids.key_vault
  network_acls = {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["0.0.0.0/0"]
  }
  reader_objects_ids = {
    "Key Vault Administrator" = {
      role_definition_name = "Key Vault Administrator"
      principal_id         = data.azurerm_client_config.current_client_config.object_id
    }
  }
  diagnostic_setting_enable  = true
  log_analytics_workspace_id = module.log-analytics.workspace_id
}

##-----------------------------------------------------------------------------
## Private DNS Zone module call
##-----------------------------------------------------------------------------
module "private_dns" {
  source              = "terraform-az-modules/private-dns/azurerm"
  version             = "1.0.4"
  location            = module.resource_group.resource_group_location
  name                = "dns"
  environment         = "dev"
  resource_group_name = module.resource_group.resource_group_name
  private_dns_config = [
    {
      resource_type = "key_vault"
      vnet_ids      = [module.vnet.vnet_id]
    },
    {
      resource_type = "mysql_server"
      vnet_ids      = [module.vnet.vnet_id]
    }
  ]
}

##-----------------------------------------------------------------------------
## Flexible Mysql server module call.
##-----------------------------------------------------------------------------
module "flexible-mysql" {
  depends_on                           = [module.resource_group, module.vnet, module.vault]
  source                               = "../../"
  name                                 = "core"
  environment                          = "dev"
  label_order                          = ["name", "environment", "location"]
  resource_group_name                  = module.resource_group.resource_group_name
  location                             = module.resource_group.resource_group_location
  delegated_subnet_id                  = module.subnet.subnet_ids["subnet1"]
  mysql_version                        = "8.0.21"
  admin_username                       = "mysqlusername"
  sku_name                             = "B_Standard_B1ms"
  db_name                              = "maindb"
  log_analytics_workspace_id           = module.log-analytics.workspace_id
  key_vault_id                         = module.vault.id
  key_vault_with_rbac                  = true
  cmk_enabled                          = true
  vnet_integration_private_dns_zone_id = module.private_dns.private_dns_zone_ids.mysql_server
  enable_private_endpoint              = false
  public_network_access                = "Disabled"
}