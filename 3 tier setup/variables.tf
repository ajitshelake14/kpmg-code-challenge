variable "LOCATION" {
  default = "West India"
}

variable "NW_RG_NAME" {
  default = "RG-KPMG-NETWORK-DEV-NE-001"
}

variable "RG_NAME" {
  default = "RG-KPMG-SHARED-DEV-NE-001"
}

variable "ENV" {
  default = "dev"
}

variable "REGION" {
  default = "inw"
}

variable "VNET_RANGE" {
  default = ""
}

variable "AKS_VNET_RANGE" {
  default = ""
}


variable "AKS_SUBNET" {
  default = ""
}

variable "APPGW_SUBNET" {
  default = ""
}

variable "DB_SUBNET" {
  default = ""
}

variable "SHARED_SUBNET" {
  default = ""
}

variable "MYSQL_USERNAME" {
  default = ""
}

variable "MYSQL_PASSWORD" {
  default = ""
}

variable "APPGW_PRIVATE_IP" {
  default = ""
}

variable "NODE_VM_SIZE" {
  default = ""
}
