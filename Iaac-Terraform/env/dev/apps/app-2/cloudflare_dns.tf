# ------------------------------------------------------------------
# Terraform for app-02 Internal LB DNS record creation on Cloud Flare.
# ------------------------------------------------------------------

# Create CNAME records for certificate manager Internal LB DNS authorization validation
resource "cloudflare_dns_record" "internal_lb_certificate_validation" {
  for_each = google_certificate_manager_dns_authorization.int_cert_dns_auth

  zone_id = var.cloudflare_zone_id
  name    = each.value.dns_resource_record[0].name
  content = each.value.dns_resource_record[0].data
  type    = "CNAME"
  ttl     = 60
  proxied = false # DNS-only, not proxied through Cloudflare
}