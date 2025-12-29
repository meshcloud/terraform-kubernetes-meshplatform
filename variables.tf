variable "namespace" {
  type        = string
  description = "Namespace where namespaced resources will be created"
  default     = "meshcloud"
}

variable "metering_enabled" {
  type    = bool
  default = true
}

variable "metering_name_suffix" {
  type        = string
  description = "Suffix to append to metering ServiceAccount and ClusterRoleBinding names to support multiple instances"
  default     = ""
}

variable "metering_existing_clusterrole_name" {
  type        = string
  description = "Name of an existing ClusterRole to use for metering instead of creating a new one. If empty, a new ClusterRole will be created."
  default     = ""
}

variable "metering_additional_rules" {
  type = list(object({
    api_groups        = list(string)
    resources         = list(string)
    verbs             = list(string)
    resource_names    = optional(list(string))
    non_resource_urls = optional(list(string))
  }))
  default = []
}

variable "replicator_enabled" {
  type    = bool
  default = true
}

variable "replicator_name_suffix" {
  type        = string
  description = "Suffix to append to replicator ServiceAccount and ClusterRoleBinding names to support multiple instances"
  default     = ""
}

variable "replicator_existing_clusterrole_name" {
  type        = string
  description = "Name of an existing ClusterRole to use for replicator instead of creating a new one. If empty, a new ClusterRole will be created."
  default     = ""
}

variable "replicator_additional_rules" {
  type = list(object({
    api_groups        = list(string)
    resources         = list(string)
    verbs             = list(string)
    resource_names    = optional(list(string))
    non_resource_urls = optional(list(string))
  }))
  default = []
}
