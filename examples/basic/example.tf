provider "azurerm" {
  features {}
}

module "flexible-mysql" {
  source = "../../"
}
