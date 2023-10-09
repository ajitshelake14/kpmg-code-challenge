# Create virtual network
resource "azurerm_virtual_network" "kpmgvnet" {
  name                = "VNET-${upper(var.env)}-${upper(var.region)}-001"
  address_space       = var.address
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}


resource "azurerm_subnet" "kpmgdbsubnet" {
  name                      = "snet-db-${var.env}-${var.region}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.kpmgvnet.name}"
  address_prefix            = "${var.dbsubnetaddress}"
  service_endpoints         = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "kpmgsharedsubnet" {
  name                      = "snet-shared-${var.env}-${var.region}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.kpmgvnet.name}"
  address_prefix            = "${var.sharedsubnetaddress}"
  service_endpoints         = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "kpmgakssubnet" {
  name                      = "snet-aks-${var.env}-${var.region}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.kpmgvnet.name}"
  address_prefix            = "${var.akssubnetaddress}"
  service_endpoints         = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "kpmgappgwsubnet" {
  name                      = "snet-agic-${var.env}-${var.region}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.kpmgvnet.name}"
  address_prefix            = "${var.appgwsubnetaddress}"
  service_endpoints         = ["Microsoft.AzureActiveDirectory","Microsoft.KeyVault","Microsoft.Storage", "Microsoft.Sql"]
}

