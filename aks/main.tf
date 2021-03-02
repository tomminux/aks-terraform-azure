## ..:: Loading Network and Subnets ::..
## ============================================================================
data "azurerm_subnet" "vnet_subnet" {

  name                 = var.subnet_name
  resource_group_name  = "${var.prefix}-rg"
  virtual_network_name = "${var.prefix}-${var.vnet_name}-vnet"

}

data "azuread_group" "aks_cluster_admins" {
  display_name = var.aks_cluster_admins_name
}

## ..:: Deploying AKS ::..
## ============================================================================

module "aks" {

  source                           = "Azure/aks/azurerm"
  resource_group_name              = "${var.prefix}-rg"
  prefix                           = var.cluster_name
  agents_availability_zones        = ["1", "2", "3"]
  kubernetes_version               = "1.18.14"
  client_id                        = var.client_id
  client_secret                    = var.client_secret

  agents_size                      = var.azure_vm_size
  agents_min_count                 = var.how_many_nodes
  agents_max_count                 = 10
  os_disk_size_gb                  = 30
  agents_max_pods                  = 100
  #agents_pool_name                 = "${var.cluster_name}pool"
  agents_pool_name                 = "defaultpool"
  agents_type                      = "VirtualMachineScaleSets"
  enable_auto_scaling              = false
  
  enable_role_based_access_control = true
  rbac_aad_managed                 = true
  rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]

  network_plugin                   = "azure"
  vnet_subnet_id                   = data.azurerm_subnet.vnet_subnet.id
  net_profile_dns_service_ip       = "192.168.0.10"
  net_profile_docker_bridge_cidr   = "172.17.0.1/16"
  net_profile_service_cidr         = "192.168.0.0/16"
  private_cluster_enabled          = var.is_private_cluster

  tags = {
    "owner": var.owner_name
  }

}
