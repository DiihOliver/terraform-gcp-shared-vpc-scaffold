# This module creates all the components for a Shared VPC Global External HTTPS
# Load Balancer, designed specifically for a Serverless NEG backend.
# The SSL certificate is # provided as an input variable.

locals {
  ip_address = var.create_static_ip ? google_compute_global_address.default[0].address : split("/", var.existing_static_ip_address)[9]
}

# ----------------------------------
# ---   HOST PROJECT RESOURCES   ---
# ----------------------------------

resource "google_compute_global_address" "default" {
  count   = var.create_static_ip ? 1 : 0
  project = var.host_project_id
  name    = "${var.prefix}-${var.name}-static-ip"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_url_map" "https_redirect" {
  count   = var.enable_http_to_https_redirect ? 1 : 0
  project = var.host_project_id
  name    = "${var.prefix}-${var.name}-http-to-https-redirect"
  default_url_redirect {
    https_redirect         = true
    strip_query            = false
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  }
}

resource "google_compute_url_map" "application_url_map" {
  project     = var.host_project_id
  name        = "${var.prefix}-${var.name}-ext-lb"
  description = "Global External Application Load Balancer for ${var.name}"
  # The default_service is used for any path that doesn't match a specific rule.
  default_service = google_compute_backend_service.default.id

  dynamic "host_rule" {
    for_each = { for i, rule in var.routing_rules : i => rule }
    content {
      hosts        = host_rule.value.hostnames
      path_matcher = "${var.prefix}-${var.name}-pm-${format("%02d", tonumber(host_rule.key) + 1)}"
    }
  }

  dynamic "path_matcher" {
    for_each = { for i, rule in var.routing_rules : i => rule }
    content {
      name            = "${var.prefix}-${var.name}-pm-${format("%02d", tonumber(path_matcher.key) + 1)}"
      default_service = google_compute_backend_service.default.id

      # This dynamic block handles the existing path-based REDIRECTS
      dynamic "path_rule" {
        for_each = { for j, redirect in path_matcher.value.path_redirects : j => redirect }
        content {
          paths   = path_rule.value.source_paths
          service = google_compute_backend_service.default.id # A service must be set even for a redirect

          dynamic "url_redirect" {
            for_each = path_rule.value.redirect_path != "" && path_rule.value.redirect_path != null ? [1] : []
            content {
              path_redirect          = path_rule.value.redirect_path
              redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
              strip_query            = false
            }
          }
        }
      }

      dynamic "path_rule" {
        for_each = var.backend_buckets
        content {
          paths          = path_rule.value.paths
          service = google_compute_backend_bucket.buckets[path_rule.key].id
        }
      }
    }
  }
}

resource "google_compute_target_http_proxy" "http_proxy" {
  count   = var.enable_http_to_https_redirect ? 1 : 0
  project = var.host_project_id
  name    = "${var.prefix}-${var.name}-target-http-proxy"
  url_map = google_compute_url_map.https_redirect[0].id
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project         = var.host_project_id
  name            = "${var.prefix}-${var.name}-target-https-proxy"
  url_map         = google_compute_url_map.application_url_map.id
  certificate_map = "//certificatemanager.googleapis.com/projects/${var.host_project_id}/locations/global/certificateMaps/${var.certificate_map_name}"
  ssl_policy      = var.ssl_policy
}

resource "google_compute_global_forwarding_rule" "http" {
  count                 = var.enable_http_to_https_redirect ? 1 : 0
  project               = var.host_project_id
  name                  = "${var.prefix}-${var.name}-http-forwarding-rule"
  target                = google_compute_target_http_proxy.http_proxy[0].self_link
  ip_address            = local.ip_address
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

resource "google_compute_global_forwarding_rule" "https" {
  project               = var.host_project_id
  name                  = "${var.prefix}-${var.name}-https-forwarding-rule"
  target                = google_compute_target_https_proxy.https_proxy.self_link
  ip_address            = local.ip_address
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

# -----------------------------------
# ---   SERVICE PROJECT RESOURCES   ---
# -----------------------------------

resource "google_compute_backend_bucket" "buckets" {
  for_each    = var.backend_buckets
  project     = var.service_project_id
  name        = "${each.key}"
  description = each.value.description
  bucket_name = each.value.bucket_name
  enable_cdn  = each.value.enable_cdn
}

resource "google_compute_backend_service" "default" {
  project               = var.service_project_id
  name                  = "${var.prefix}-${var.name}-backend-service"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  enable_cdn            = var.enable_cdn
  backend {
    group = "https://www.googleapis.com/compute/v1/projects/${var.service_project_id}/regions/${var.backend_config.region}/networkEndpointGroups/${var.backend_config.neg_name}"
  }
}
