# meshfed_metering service account
resource "kubernetes_service_account" "meshfed_metering" {
  metadata {
    name      = var.name_suffix != "" ? "meshfed-metering-${var.name_suffix}" : "meshfed-metering"
    namespace = var.namespace
    annotations = {
      "io.meshcloud/meshstack.metering-kubernetes.version" = "1.0"
    }
  }
}

# Moved blocks for smooth upgrades from count-less to count-based resources
moved {
  from = kubernetes_cluster_role.meshfed-metering
  to   = kubernetes_cluster_role.meshfed-metering[0]
}

# meshfed_metering secret
resource "kubernetes_secret" "meshfed_metering_secret" {
  metadata {
    name      = var.name_suffix != "" ? "meshfed-metering-${var.name_suffix}" : "meshfed-metering"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.meshfed_metering.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

###
# meshfed_metering cluster role (shared across all instances)
resource "kubernetes_cluster_role" "meshfed-metering" {
  count = var.existing_clusterrole_name != "" ? 0 : 1

  metadata {
    name = "meshfed-metering"
    annotations = {
      "io.meshcloud/meshstack.metering-kubernetes.version" = "1.0"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["pods", "persistentvolumeclaims"]
    verbs      = ["get", "list"]
  }

  dynamic "rule" {
    for_each = var.additional_rules
    content {
      api_groups        = rule.value.api_groups
      resources         = rule.value.resources
      verbs             = rule.value.verbs
      resource_names    = rule.value.resource_names
      non_resource_urls = rule.value.non_resource_urls
    }
  }

}

# meshfed_metering role binding (unique per instance)
resource "kubernetes_cluster_role_binding" "meshfed-metering" {
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.meshfed_metering.metadata[0].name
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.existing_clusterrole_name != "" ? var.existing_clusterrole_name : "meshfed-metering"
  }
  metadata {
    name = var.name_suffix != "" ? "meshfed-metering-${var.name_suffix}" : "meshfed-metering"
    annotations = {
      "io.meshcloud/meshstack.metering-kubernetes.version" = "1.0"
    }
  }
}

