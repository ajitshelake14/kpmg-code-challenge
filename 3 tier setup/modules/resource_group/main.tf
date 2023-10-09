# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "kpmgrg" {
  name     = "RG-${upper(var.profile)}-${upper(var.env)}-${upper(var.region)}-001"
  location = "${var.location}"

  tags = {
    env    = "${var.env}"
  }
}

resource "azurerm_resource_group" "kpmgnwrg" {
  name     = "RG-${upper(var.profile)}-${upper(var.env)}-${upper(var.region)}-001"
  location = "${var.location}"

  tags = {
    env    = "${var.env}"
  }
}
