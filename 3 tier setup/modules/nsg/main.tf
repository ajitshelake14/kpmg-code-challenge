# Create Network Security Group and rule
resource "azurerm_network_security_group" "kpmgagicnsg" {
  name                = "nsg-agic-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "Standard443_8080"
    description                = ""
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AppInsight"
    description                = ""
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "ApplicationInsightsAvailability"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AzureMonitor"
    description                = ""
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["443","80"]
    source_address_prefix      = "AzureMonitor"
    destination_address_prefix = "VirtualNetwork"
  }
 

  security_rule {
    name                       = "DenyAll"
    description                = ""
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "kpmgaksnsg" {
  name                = "nsg-aks-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "Standard443_8080"
    description                = ""
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AppInsight"
    description                = ""
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "ApplicationInsightsAvailability"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow-kpmg-pod"
    description                = ""
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["10250","22"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AzureMonitor"
    description                = ""
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["443","80"]
    source_address_prefix      = "AzureMonitor"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "DenyAll"
    description                = ""
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-80-8080"
    description                = ""
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["80","8080"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }


  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}


resource "azurerm_subnet_network_security_group_association" "akssubnet" {
  subnet_id                 = "${var.aks_subnet_id}"
  network_security_group_id = azurerm_network_security_group.kpmgaksnsg.id
}





# Create Network Security Group and rule
resource "azurerm_network_security_group" "kpmgdbnsg" {
  name                = "nsg-db-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "Standard443_8080"
    description                = ""
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AppInsight"
    description                = ""
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "ApplicationInsightsAvailability"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-port-3306"
    description                = ""
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AzureMonitor"
    description                = ""
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["443","80"]
    source_address_prefix      = "AzureMonitor"
    destination_address_prefix = "VirtualNetwork"
  }

 
  security_rule {
    name                       = "DenyAll"
    description                = ""
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AzureMonitor"
    description                = ""
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["6380"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }


  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}


resource "azurerm_subnet_network_security_group_association" "dbsubnet" {
  subnet_id                 = "${var.db_subnet_id}"
  network_security_group_id = azurerm_network_security_group.kpmgdbnsg.id
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "kpmgsharednsg" {
  name                = "nsg-shared-${var.env}-${var.region}-001"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "Standard443_8080"
    description                = ""
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AppInsight"
    description                = ""
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "ApplicationInsightsAvailability"
    destination_address_prefix = "VirtualNetwork"
  }


  security_rule {
    name                       = "AzureMonitor"
    description                = ""
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["443","80"]
    source_address_prefix      = "AzureMonitor"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "DenyAll"
    description                = ""
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-redis-host"
    description                = ""
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges     = "6380"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow_53Inbound"
    description                = ""
    priority                   = 160
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}

resource "azurerm_subnet_network_security_group_association" "sharedsubnet" {
  subnet_id                 = "${var.shared_subnet_id}"
  network_security_group_id = azurerm_network_security_group.kpmgsharednsg.id
}

#####################################

