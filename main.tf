terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.15.0"
    }
  }
}

# Kubernetes Namespace
resource "kubernetes_namespace" "meshcloud" {
  metadata {
    name = var.namespace
  }
}

module "meshcloud-service-account-meshfed-metering" {
  count                     = var.metering_enabled ? 1 : 0
  source                    = "./modules/meshcloud-service-account-meshfed-metering"
  namespace                 = kubernetes_namespace.meshcloud.metadata.0.name
  name_suffix               = var.metering_name_suffix
  existing_clusterrole_name = var.metering_existing_clusterrole_name
  additional_rules          = var.metering_additional_rules
}

module "meshcloud-service-account-meshfed-replicator" {
  count                     = var.replicator_enabled ? 1 : 0
  source                    = "./modules/meshcloud-service-account-meshfed-replicator"
  namespace                 = kubernetes_namespace.meshcloud.metadata.0.name
  name_suffix               = var.replicator_name_suffix
  existing_clusterrole_name = var.replicator_existing_clusterrole_name
  additional_rules          = var.replicator_additional_rules
}
