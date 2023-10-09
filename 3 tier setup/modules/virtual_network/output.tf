output "id" {
  value = "${azurerm_virtual_network.kpmgvnet.id}"
}

output "name" {
  value = "${azurerm_virtual_network.kpmgvnet.name}"
}

output "appgwsubnet" {
  value = "${azurerm_subnet.kpmgappgwsubnet.id}"
}

output "appgwsubnetname" {
  value = "${azurerm_subnet.kpmgappgwsubnet.name}"
}

output "vnetaddress" {
  value = "${azurerm_virtual_network.kpmgvnet.address_space}"
}

output "dbsubnet" {
  value = "${azurerm_subnet.kpmgdbsubnet.id}"
}

output "dbsubnetname" {
  value = "${azurerm_subnet.kpmgdbsubnet.name}"
}

output "sharedsubnet" {
  value = "${azurerm_subnet.kpmgsharedsubnet.id}"
}

output "sharedsubnetname" {
  value = "${azurerm_subnet.kpmgsharedsubnet.name}"
}

output "akssubnet" {
  value = "${azurerm_subnet.kpmgakssubnet.id}"
}

output "akssubnetname" {
  value = "${azurerm_subnet.kpmgakssubnet.name}"
}