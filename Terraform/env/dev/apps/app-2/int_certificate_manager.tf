resource "google_certificate_manager_dns_authorization" "int_cert_dns_auth" {
  for_each = { for cert_name, config in var.int_certificates : config.domain_name => config }
  project  = var.host_project_id
  name     = "dns-auth-${replace(each.key, ".", "-")}"
  type     = "PER_PROJECT_RECORD"
  description = "DNS authorization for ${each.key}"
  domain      = each.key
  location    = var.region
}

resource "google_certificate_manager_certificate" "int_cert" {
  for_each    = var.int_certificates
  project     = var.host_project_id
  name        = each.key
  description = each.value.description
  location    = var.region

  managed {
    domains = [each.value.domain_name]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.int_cert_dns_auth[each.value.domain_name].id
    ]
  }
}
