resource "google_certificate_manager_dns_authorization" "dns_auth" {
  for_each    = toset(var.domain_names)
  project     = var.host_project_id
  name        = "${var.certificate_name}-dns-auth-${replace(each.key, ".", "-")}"
  description = "DNS Authorization for ${each.key}"
  domain      = each.key
  location    = var.location
}

resource "google_certificate_manager_certificate" "managed_cert" {
  project     = var.host_project_id
  name        = var.certificate_name
  description = var.certificate_description
  location    = var.location

  managed {
    domains = var.domain_names 
    dns_authorizations = [
      for auth in google_certificate_manager_dns_authorization.dns_auth : auth.id
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [google_certificate_manager_dns_authorization.dns_auth]
}

resource "google_certificate_manager_certificate_map" "cert_map" {
  project     = var.host_project_id
  name        = var.certificate_map_name
  description = var.certificate_map_description
  # location    = var.location
}

resource "google_certificate_manager_certificate_map_entry" "cert_map_entry" {
  for_each    = toset(var.domain_names)
  project     = var.host_project_id
  map         = google_certificate_manager_certificate_map.cert_map.name
  name        = "${var.certificate_map_name}-entry"
  description = "Map entry for ${each.key}"
  hostname    = each.key
  certificates = [google_certificate_manager_certificate.managed_cert.id]
  # location    = var.location

  depends_on = [google_certificate_manager_certificate.managed_cert]
}
