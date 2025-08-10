output "shared_vpc_host_project_id" {
  description = "The GCP project ID configured as the Shared VPC host."
  value       = google_compute_shared_vpc_host_project.host.project
}

output "attached_service_project_ids" {
  description = "A list of service project IDs that have been attached to the Shared VPC host project."
  value       = keys(google_compute_shared_vpc_service_project.service_project_attachment)
}

output "service_project_to_shared_subnets_config" {
  description = "The configuration map defining which subnets are shared with which service projects. Keys are service project IDs, values are lists of subnet paths."
  value       = var.service_project_subnet_sharing
  # This output directly reflects the input variable that drives the subnet sharing logic.
  # Set sensitive = true if this mapping is considered confidential.
  # sensitive = false
}

# Optional: If you also want to see all subnets created by the networking module,
# you could add an output for that (assuming your 'svc_project_networking' module
# has an output like 'all_subnet_details_map' or similar).
# For example:
#
# output "created_vpc_subnets_overview" {
#   description = "Overview of all subnets created by the networking module, keyed by VPC."
#   value = {
#     for vpc_key, vpc_instance in module.svc_project_networking : vpc_key => {
#       # Assuming 'vpc_instance.subnets_data' is a list of objects with 'name' and 'self_link'
#       subnets = [for subnet in vpc_instance.subnets_data : { name = subnet.name, self_link = subnet.self_link }]
#     } if vpc_instance.subnets_data != null
#   }
# }