output "agicsubnetnsgid" {
  value = "${azurerm_network_security_group.kpmgagicnsg.id}"
}

output "agicsubnetnsgname" {
  value = "${azurerm_network_security_group.kpmgagicnsg.name}"
}

output "akssubnetnsgid" {
  value = "${azurerm_network_security_group.kpmgaksnsg.id}"
}

output "akssubnetnsgname" {
  value = "${azurerm_network_security_group.kpmgaksnsg.name}"
}


output "dbsubnetnsgid" {
  value = "${azurerm_network_security_group.kpmgdbnsg.id}"
}

output "dbsubnetnsgname" {
  value = "${azurerm_network_security_group.kpmgdbnsg.name}"
}

output "sharedsubnetnsgid" {
  value = "${azurerm_network_security_group.kpmgsharednsg.id}"
}

output "sharedsubnetnsgname" {
  value = "${azurerm_network_security_group.kpmgsharednsg.name}"
}




