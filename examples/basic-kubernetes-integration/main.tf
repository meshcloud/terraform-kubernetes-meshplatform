provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "..." # Name of the config context
}

module "meshplatform" {
  source = "../.."
}
