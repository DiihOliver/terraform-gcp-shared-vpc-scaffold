# ------------------------------------------------------------------
# Terraform for GCP Private DNS record creation on GCP Cloud DNS.
# ------------------------------------------------------------------

resource "google_dns_record_set" "internal_lb_records" {
  for_each = var.int_certificates

  project      = var.host_project_id
  managed_zone = "dev-staging-private-dns-zone"
  name = "${each.value.domain_name}."

  type    = "A"
  ttl     = 300 
  rrdatas = [module.regional_internal_lb.load_balancer_ip_address]
  depends_on = [module.regional_internal_lb]
}
