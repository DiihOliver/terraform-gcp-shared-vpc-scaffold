# modules/gcp-shared-vpc-lb/outputs.tf

output "ip_address" {
  description = "The external IPv4 address assigned to the load balancer."
  value       = local.ip_address
}

# output "certificate_name" {
#   description = "The name of the Google-managed SSL certificate."
#   value       = google_compute_managed_ssl_certificate.default.name
# }

output "backend_service_name" {
  description = "The name of the backend service created in the Service Project."
  value       = google_compute_backend_service.default.name
}

output "https_proxy_self_link" {
  description = "The self-link of the HTTPS proxy used by this module."
  value       = google_compute_target_https_proxy.https_proxy.self_link
}

output "backend_buckets" {
  description = "A map of the created backend buckets, including their names and self-links."
  value = {
    for key, bucket in google_compute_backend_bucket.buckets : key => {
      name      = bucket.name
      id        = bucket.id
      # self_link = bucket.self_link
    }
  }
}