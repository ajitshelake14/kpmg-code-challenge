resource "azurerm_public_ip" "kpmgpip" {
  name                         = "agw-${var.env}-${var.region}-public-ip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  sku                          = "standard"
  allocation_method            = "Static"

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
    
  }
}

# Create an application gateway
resource "azurerm_application_gateway" "kpmgappgateway" {
  name                = "agw-${var.env}-${var.region}-001"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
  }

  gateway_ip_configuration {
    name      = "appgw-${var.env}-${var.region}-ipconf"
    subnet_id = "${var.subnet_id}"
  }

  frontend_port {
    name = "appgw-${var.env}-${var.region}-httpsport"
    port = 443
  }

  frontend_ip_configuration {
    name                          = "appgw-${var.env}-${var.region}-privateip"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.private_ip_address}"

  }

  frontend_ip_configuration {
    name                          = "appgw-${var.env}-${var.region}-publicip"
    public_ip_address_id            = "${azurerm_public_ip.falconpip.id}"

  }


  backend_address_pool {
    name            = "appgw-${var.env}-${var.region}-bepool"
    ip_addresses    = "${var.ip_address_list}"
  }

  backend_http_settings {
    name                  = "appgw-${var.env}-${var.region}-httpsetting"
    cookie_based_affinity = "Enabled"
    port                  = "${var.backend_http_port}"
    protocol              = "Http"
    request_timeout       = 300
    probe_name            = "${var.backend_http_probe_name}"


  }

  http_listener {
    name                           = "appgw-${var.env}-${var.region}-httplstn"
    frontend_ip_configuration_name = "appgw-${var.env}-${var.region}-privateip"
    frontend_port_name             = "appgw-${var.env}-${var.region}-httpport"
    protocol                       = "Http"

  }

  request_routing_rule {
    name                       = "appgw-${var.env}-${var.region}-rqrt-http"
    rule_type                  = "Basic"
    http_listener_name         = "appgw-${var.env}-${var.region}-httplstn"
    backend_address_pool_name  = "appgw-${var.env}-${var.region}-bepool"
    backend_http_settings_name = "appgw-${var.env}-${var.region}-httpsetting"
  }

  probe {
      host                           = "${var.probe_host}"
      pick_host_name_from_backend_http_settings = "${var.probe_host_backend}"
      protocol                       = "http"
      path                           = "${var.probe_path}"
      timeout                        = 30
      unhealthy_threshold            = 3
      minimum_servers                = 0
      interval                       = 30
      name                           = "http-health-probe"
   }

   tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}

