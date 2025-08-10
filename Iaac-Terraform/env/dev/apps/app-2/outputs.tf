output "artifact_registry_details" {
  value       = module.artifact_registry["repo_01"].repo_name
  description = "The details of the Artifact Registry"
}

output "cloud_run_service_name" {
  value       = module.cloud_run_v2["app-02"].service_name
  description = "Name of the created service"
}

output "custom_role_name" {
  value       = module.custom_roles["app-02"].custom_role_id 
  description = "Name of the created custom role name"
}

output "service_account_name" {
  value       = module.service_accounts["app-02"].email
  description = "Name of the created service account name"
}

# Serverless Negs:
output "serverless_neg_names" {
  description = "A list of the names of the created Serverless NEGs."
  value       = [for key in keys(var.serverless_negs) : "${var.neg-name}"]
}

# Internal certificates:
output "internal_dns_authorizations" {
  description = "A map of domain names to the CNAME records that must be created in your DNS provider to prove domain ownership for the internal certificate."
  value = {
    for domain, auth in google_certificate_manager_dns_authorization.int_cert_dns_auth : domain => {
      cname_name  = auth.dns_resource_record[0].name
      cname_value = auth.dns_resource_record[0].data
    }
  }
}

output "internal_certificate_names" {
  description = "A list of the names of the regional Google-managed certificates."
  value       = [for cert in google_certificate_manager_certificate.int_cert : cert.name]
}


# Internal Load balancers:
output "int_load_balancer_ip_address" {
  description = "The IP address of the regional internal load balancer."
  value       = module.regional_internal_lb.load_balancer_ip_address
}
