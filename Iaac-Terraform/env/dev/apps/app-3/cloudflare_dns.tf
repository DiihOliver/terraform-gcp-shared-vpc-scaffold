# ------------------------------------------------------------------
# Terraform for app-03 DNS record creation on Cloud Flare.
# ------------------------------------------------------------------

# Create CNAME records for certificate manager DNS authorization validation
resource "cloudflare_dns_record" "certificate_validation" {
  for_each = google_certificate_manager_dns_authorization.dns_auth

  zone_id = var.cloudflare_zone_id
  name    = each.value.dns_resource_record[0].name
  content = each.value.dns_resource_record[0].data
  type    = "CNAME"
  ttl     = 60
  proxied = false # DNS-only, not proxied through Cloudflare
}

# Create A record for the external load balancer
resource "cloudflare_dns_record" "load_balancer" {
  for_each = toset(var.domain_names)

  zone_id = var.cloudflare_zone_id
  name    = each.value
  content = module.shared_vpc_lb.ip_address
  type    = "A"
  ttl     = 1
  proxied = true # Proxied through Cloudflare for security and performance
}


