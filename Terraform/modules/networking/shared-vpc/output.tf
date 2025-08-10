
#SHARED VPC

output "network" {
  value       = google_compute_network.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}

output "project_id" {
  value       = google_compute_network.network.project
  description = "VPC project id"
}

#SUBNETS

output "subnets_names" {
  value       = [for network in module.host_prj_svpc_subnets.subnets : network.name]
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = [for network in module.host_prj_svpc_subnets.subnets : network.ip_cidr_range]
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_regions" {
  value       = [for network in module.host_prj_svpc_subnets.subnets : network.region]
  description = "The region where the subnets will be created"
}
