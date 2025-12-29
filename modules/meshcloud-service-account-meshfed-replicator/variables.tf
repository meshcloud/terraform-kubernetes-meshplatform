variable "namespace" {
  type = string
}

variable "name_suffix" {
  type        = string
  description = "Suffix to append to ClusterRole and ClusterRoleBinding names to support multiple instances"
  default     = ""
}

variable "existing_clusterrole_name" {
  type        = string
  description = "Name of an existing ClusterRole to use instead of creating a new one. If empty, a new ClusterRole will be created."
  default     = ""
}

variable "additional_rules" {
  type = list(object({
    api_groups        = list(string)
    resources         = list(string)
    verbs             = list(string)
    resource_names    = optional(list(string))
    non_resource_urls = optional(list(string))
  }))
  default = []
}
