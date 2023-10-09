

resource "azurerm_kubernetes_cluster" "kpmgakscluster" {
  name                = "aks-${var.env}-${var.region}-001"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  dns_prefix          = "aks-${var.env}-${var.region}-001"
  kubernetes_version  = "1.25.4"
  private_cluster_enabled = "true"
  node_resource_group = "${var.node_resource_group_name}"
  public_network_access_enabled = "false"

  role_based_access_control  {
    enabled            = "true"
    azure_active_directory {
      managed = "true"
      azure_rbac_enabled = "true"
    } 
    
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = "${var.aks_node_count}"
    vm_size         = "${var.vm_size}"
    os_disk_size_gb = "128"
    os_disk_type    = "Managed"
    os_sku          = "Ubuntu"
    type            = "VirtualMachineScaleSets"
    availability_zones   = [1,2,3]
    enable_auto_scaling = "true"
    orchestrator_version = "1.25.4"
    fips_enabled    = "false"
    max_pods        = "30"
    vnet_subnet_id  = "${var.cluster_subnet_id}"
    
  }


  addon_profile {
    azure_keyvault_secrets_provider {
      enabled = true
      secret_rotation_enabled = false
      secret_rotation_interval = "2m"
      
    }

    ingress_application_gateway  {
       enabled      = "${var.enable_agic}"
       gateway_name = "${var.appgw_name}"
       subnet_id    = "${var.appgw_subnet_id}"
       gateway_id   = "${var.gateway_id}"
    }

  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
    network_policy = "azure"
  }

  tags = {
    appid          = "tech-challenge"
    environment    = "${var.env}"
    country        = "India"
    project        = "KPMG"
    bu             = "India"
  }
}

