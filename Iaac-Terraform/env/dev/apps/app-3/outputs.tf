output "artifact_registry_details" {
  value       = module.artifact_registry["repo_01"].repo_name
  description = "The details of the Artifact Registry"
}

output "cloud_run_service_name" {
  value       = module.cloud_run_v2["app-03"].service_name
  description = "Name of the created service"
}

output "custom_role_name" {
  value       = module.custom_roles["app-03"].name
  description = "Name of the created custom role name"
}

output "service_account_name" {
  value       = module.service_accounts["app-03"].email
  description = "Name of the created service account name"
}

# Serverless Negs:
output "serverless_neg_names" {
  description = "A list of the names of the created Serverless NEGs."
  value       = [for key in keys(var.serverless_negs) : "${var.neg-name}"]
}

# Global Cerificates:
output "certificate_id" {
  description = "The fully qualified ID of the Certificate Manager certificate."
  value       = google_certificate_manager_certificate.managed_cert.id
}

output "certificate_managed_domains" {
  description = "The list of domains this certificate is managing."
  value       = google_certificate_manager_certificate.managed_cert.managed[0].domains
}

# Global Load balancer:
output "ext_load_balancer_ip_address" {
  description = "The public IP address of the load balancer."
  value       = module.shared_vpc_lb.ip_address
}

output "dns_records_for_cloudflare" {
  description = "A map of CNAME records to create in Cloudflare. The key is the domain name."
  value = {
    for domain, auth in google_certificate_manager_dns_authorization.dns_auth : domain => {
      cname_name  = auth.dns_resource_record[0].name
      cname_value = auth.dns_resource_record[0].data
    }
  }
}