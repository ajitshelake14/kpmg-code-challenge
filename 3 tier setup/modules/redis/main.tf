# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "kpmgredis" {
  name                = "rc-${var.profile}-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"
  public_network_access_enabled = false

  redis_configuration {
  }

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}


resource "azurerm_private_endpoint" "redisendpoint" {
  name                = "pl-rc-${var.profile}-${var.env}-${var.region}-001"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  subnet_id           = "${var.pvt_endpt_subnet}"
  private_service_connection {
    name                           = "ps-rc-${var.profile}-${var.env}-${var.region}-001"
    private_connection_resource_id = azurerm_redis_cache.kpmgredis.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}

