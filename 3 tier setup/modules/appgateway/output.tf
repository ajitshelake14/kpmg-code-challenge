output "appgwname" {
  value = "${azurerm_application_gateway.kpmgappgateway.name}"
}

output "appgwid" {
  value = "${azurerm_application_gateway.kpmgappgateway.id}"
}
