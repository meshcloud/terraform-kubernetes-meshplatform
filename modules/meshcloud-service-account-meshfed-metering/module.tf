# meshfed_metering service account
resource "kubernetes_service_account" "meshfed_metering" {
  metadata {
    name      = "meshfed-metering"
    namespace = var.namespace
    annotations = {
      "io.meshcloud/meshstack.metering-kubernetes.version" = "1.0"
    }
  }
}

# meshfed_metering secret
resource "kubernetes_secret" "meshfed_metering_secret" {
  metadata {
    name      = "meshfed-metering"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.meshfed_metering.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

###
# meshfed_metering cluster role
resource "kubernetes_cluster_role" "meshfed-metering" {
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

# meshfed_metering role binding
resource "kubernetes_cluster_role_binding" "meshfed-metering" {
  subject {
    kind      = "ServiceAccount"
    name      = "meshfed-metering"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "meshfed-metering"
  }
  metadata {
    name = "meshfed-metering"
    annotations = {
      "io.meshcloud/meshstack.metering-kubernetes.version" = "1.0"
    }
  }
}

