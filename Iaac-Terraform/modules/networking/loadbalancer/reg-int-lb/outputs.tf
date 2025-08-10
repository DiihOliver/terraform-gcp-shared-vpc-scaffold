/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 *
 * Outputs for the Regional Internal Application Load Balancer module.
 */

output "backend_services" {
  description = "The regional backend service resources created by this module."
  value       = google_compute_region_backend_service.default
}

# output "internal_ip" {
#   description = "The regional internal IPv4 address assigned to the forwarding rule."
#   value       = local.int_static_address
# }

output "load_balancer_ip_address" {
  description = "The IP address of the regional internal load balancer."
  value       = google_compute_forwarding_rule.https.ip_address
}

# output "http_proxy" {
#   description = "The self-link of the regional HTTP proxy used by this module."
#   value       = one(google_compute_region_target_http_proxy.default[*].self_link)
# }

output "https_proxy" {
  description = "The self-link of the regional HTTPS proxy used by this module."
  value       = one(google_compute_region_target_https_proxy.default[*].self_link)
}

output "url_map" {
  description = "The self-link of the default regional URL map used by this module."
  value       = one(google_compute_region_url_map.default[*].self_link)
}

# output "ssl_certificate_created" {
#   description = "The self-link of the regional SSL certificate created by this module."
#   value       = one(google_compute_region_ssl_certificate.default[*].self_link)
# }

# output "forwarding_rule_http" {
#   description = "The self-link of the HTTP forwarding rule."
#   value       = one(google_compute_forwarding_rule.http[*].self_link)
# }

output "forwarding_rule_https" {
  description = "The self-link of the HTTPS forwarding rule."
  value       = one(google_compute_forwarding_rule.https[*].self_link)
}
