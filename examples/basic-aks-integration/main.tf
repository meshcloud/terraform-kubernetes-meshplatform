terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}

resource "azurerm_resource_group" "aks-demo-cluster" {
  name     = "aks-demo-cluster"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "aks-demo-cluster" {
  name                = "aks-demo-cluster"
  location            = azurerm_resource_group.aks-demo-cluster.location
  resource_group_name = azurerm_resource_group.aks-demo-cluster.name
  dns_prefix          = "aks-demo-cluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = true
    admin_group_object_ids = ["00000000-0000-0000-0000-000000000000"]
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "aks-demo-cluster"
}

module "aks_meshplatform" {
  source = "git@github.com:meshcloud/terraform-kubernetes-meshplatform.git"

  depends_on = [
    azurerm_kubernetes_cluster.aks-demo-cluster
  ]
}

## METERING
output "metering_token" {
  value     = module.aks_meshplatform.metering_token
  sensitive = true
}

output "metering_expose_token" {
  value = module.aks_meshplatform.metering_expose_token
}

## REPLICATOR
output "replicator_token" {
  value     = module.aks_meshplatform.replicator_token
  sensitive = true
}

output "replicator_expose_token" {
  value = module.aks_meshplatform.replicator_expose_token
}
