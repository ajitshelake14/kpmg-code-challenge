resource "azurerm_route_table" "routetable" {
  name                = "rt-${var.profile}-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  disable_bgp_route_propagation = true
 
  route {
    name           = "kpmgtoFirewall"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.0.4"
  }

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
 }

resource "azurerm_subnet_route_table_association" "devdbsubnet" {
  subnet_id      = "${var.dbsubnetid}"
  route_table_id = "${azurerm_route_table.routetable.id}"
}
