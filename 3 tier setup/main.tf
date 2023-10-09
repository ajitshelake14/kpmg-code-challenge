provider "azurerm" {
  version =  "~> 2.12"
  features {}
}

module "resource_group" {
  source              = "./modules/resource_group"
  location            = "${var.LOCATION}"
  resource_group_name = "${var.RG_NAME}"
  env                 = "${var.ENV}"
}

module "resource_group" {
  source              = "./modules/resource_group"
  location            = "${var.LOCATION}"
  resource_group_name = "${var.NW_RG_NAME}"
  env                 = "${var.ENV}"
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = "${var.NW_RG_NAME}"
  location            = "${var.LOCATION}"
  env                 = "${var.ENV}"
  region              = "${var.REGION}"
  agic_subnet_id      = "${module.virtual_network.appgwsubnet}"
  aks_subnet_id       = "${module.virtual_network.akssubnet}"
  db_subnet_id        = "${module.virtual_network.dbsubnet}"
  shared_subnet_id    = "${module.virtual_network.sharedsubnet}"

}

module "agicroute" {
  source               = "./modules/route"
  location             = "${var.LOCATION}"
  resource_group_name  = "${var.NW_RG_NAME}"
  env                  = "${var.ENV}"
  profile              = "agic"
  region               = "${var.REGION}"
}

module "aksroute" {
  source               = "./modules/route"
  location             = "${var.LOCATION}"
  resource_group_name  = "${var.NW_RG_NAME}"
  env                  = "${var.ENV}"
  profile              = "aks"
  region               = "${var.REGION}"
}

module "dbroute" {
  source               = "./modules/route"
  location             = "${var.LOCATION}"
  resource_group_name  = "${var.NW_RG_NAME}"
  env                  = "${var.ENV}"
  profile              = "db"
  region               = "${var.REGION}"
}

module "virtual_network" {
  source               = "./modules/virtual_network"
  location             = "${var.LOCATION}"
  resource_group_name  = "${var.RG_NAME}"
  address              =  [var.AKS_VNET_RANGE,var.VNET_RANGE]
  akssubnetaddress     = "${var.AKS_SUBNET}"
  appgwsubnetaddress   = "${var.APPGW_SUBNET}"
  sharedsubnetaddress  = "${var.SHARED_SUBNET}"
  dbsubnetaddress      = "${var.DB_SUBNET}"
  env                  = "${var.ENV}"
  profile              = "iaas"
  region               = "${var.REGION}"
  route_id             = "${module.aksroute.id}"
}

module "mysql" {
  source              = "./modules/mysql"
  location            = "${var.LOCATION}"
  resource_group_name = "${var.RG_NAME}"
  env                 = "${var.ENV}"
  profile             = "mysqldb"
  region              = "${var.REGION}"
  pvt_endpt_subnet    = "${module.virtual_network.dbsubnet}"
  audit_account_id    = "${module.auditstorageaccount.id}"
  mysql_username      = "${var.MYSQL_USERNAME}"
  mysql_password      = "${var.MYSQL_PASSWORD}"
}

module "rediscache" {
  source              = "./modules/redis"
  location            = "${var.LOCATION}"
  resource_group_name = "${var.RG_NAME}"
  env                 = "${var.ENV}"
  profile             = "cache"
  region              = "${var.REGION}"
  pvt_endpt_subnet    = "${module.virtual_network.sharedsubnet}"
  
}


module "agiccpeappgateway" {
  source              = "./modules/appgateway"
  location            = "${var.LOCATION}"
  resource_group_name = "${var.RG_NAME}"
  subnet_id           = "${module.virtual_network.appgwsubnet}"
  private_ip_address  = "${var.APPGW_PRIVATE_IP}"
  ip_address_list     = ["10.25.0.70"]
  probe_path          = "/FileNet/Engine"
  probe_host          = "10.25.0.70"
  backend_http_probe_name = "http-health-probe"
  probe_host_backend  = "false"
  backend_http_port   = "80"
  tls_version         = "TLSv1_2"
  profile             = "kpmgagic"
  region              = "${var.REGION}"
  env                 = "${var.ENV}"
}


module "cluster" {
  source                = "./modules/aks"
  location              = "${var.LOCATION}"
  resource_group_name   = "${var.RG_NAME}"
  env                   = "${var.ENV}"
  region                = "${var.REGION}"
  vm_size               = "${var.NODE_VM_SIZE}"
  cluster_subnet_id     = "${module.virtual_network.akssubnet}"
  appgw_subnet_id       = "${module.virtual_network.akssubnet}"
  appgw_name            = "agw-${var.ENV}-${var.REGION}-001"
  gateway_id            =  "${module.appgateway.id}"
  enable_agic           = "true"
  aks_node_count        = "2"
}

