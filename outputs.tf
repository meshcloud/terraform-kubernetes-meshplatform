## METERING
output "metering_token" {
  value = module.meshcloud-service-account-meshfed-metering.token_metering
  sensitive = true
}

output "metering_expose_token" {
  value = module.meshcloud-service-account-meshfed-metering.expose_token
}


## REPLICATOR

output "replicator_token" {
  value = module.meshcloud-service-account-meshfed-replicator.token_replicator
  sensitive = true
}

output "replicator_expose_token" {
  value = module.meshcloud-service-account-meshfed-replicator.expose_token
}