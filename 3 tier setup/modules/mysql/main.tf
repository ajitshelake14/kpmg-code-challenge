resource "azurerm_mysql_server" "kpmgmysqldb" {
  name                = "sql-${var.profile}-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  administrator_login          = "${var.mysql_username}"
  administrator_login_password = "${var.mysql_password}"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"


  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}


resource "azurerm_private_endpoint" "mysqlendpoint" {
  name                = "pl-mysql-${var.profile}-${var.env}-${var.region}-001"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  subnet_id           = "${var.pvt_endpt_subnet}"
  private_service_connection {
    name                           = "ps-mysql-${var.profile}-${var.env}-${var.region}-001"
    private_connection_resource_id = azurerm_mysql_server.kpmgmysqldb.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}



