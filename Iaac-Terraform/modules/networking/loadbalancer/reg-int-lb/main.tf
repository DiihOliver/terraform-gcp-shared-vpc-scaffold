locals {
  # These three lines determine which IP address source to use.
  created_address    = var.int_create_address ? google_compute_address.default[0].address : null
  looked_up_address  = !var.int_create_address && var.int_address_name != null ? data.google_compute_address.existing[0].address : null
  int_static_address = coalesce(local.created_address, local.looked_up_address, var.address)
  default_backend    = keys(var.backends)[0]
}

data "google_compute_address" "existing" {
  count = !var.int_create_address && var.int_address_name != null ? 1 : 0

  project = var.host_project_id
  name    = var.int_address_name
  region  = var.region
}

# ========================================================================================
# FRONTEND CONFIGURATION (HOST PROJECT)
# ========================================================================================

resource "google_compute_address" "default" {
  count        = var.int_create_address ? 1 : 0
  project      = var.host_project_id
  name         = "${var.name}-address"
  address_type = "INTERNAL"
  # network      = var.network_self_link
  subnetwork = var.subnet_self_link
  region     = var.region
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_forwarding_rule" "https" {
  project     = var.host_project_id
  name        = "${var.name}-fr"
  region      = var.region
  ip_protocol = "TCP"
  port_range  = "443"
  ip_address            = local.int_static_address
  target                = google_compute_region_target_https_proxy.default.self_link
  load_balancing_scheme = "INTERNAL_MANAGED"
  network               = var.network_self_link
  subnetwork            = var.subnet_self_link
  labels                = var.labels
}

# ========================================================================================
# PROXIES & URL MAPS (HOST PROJECT)
# ========================================================================================

resource "google_compute_region_target_https_proxy" "default" {
  project                          = var.host_project_id
  name                             = "${var.name}-https-proxy"
  region                           = var.region
  url_map                          = google_compute_region_url_map.default.self_link
  certificate_manager_certificates = [for name in var.certificate_names : "//certificatemanager.googleapis.com/projects/${var.host_project_id}/locations/${var.region}/certificates/${name}"]
  # certificate_manager_certificates = ["//certificatemanager.googleapis.com/projects/${var.host_project_id}/locations/${var.region}/certificates/${var.certificate_name}"]
}


resource "google_compute_region_url_map" "default" {
  project = var.host_project_id
  name    = "${var.name}"
  region  = var.region

  default_service = google_compute_region_backend_service.default[local.default_backend].self_link

  dynamic "host_rule" {
    for_each = var.int_lb_routing_rules
    content {
      hosts        = host_rule.value.hosts
      path_matcher = host_rule.value.path_matcher
    }
  }

  dynamic "path_matcher" {
    for_each = { for rule in var.int_lb_routing_rules : rule.path_matcher => rule }
    content {
      name            = path_matcher.key
      default_service = google_compute_region_backend_service.default[local.default_backend].self_link

      dynamic "path_rule" {
        for_each = path_matcher.value.paths
        content {
          paths   = path_rule.value.paths
          service = path_rule.value.backend != null ? google_compute_region_backend_service.default[path_rule.value.backend].self_link : null

          dynamic "url_redirect" {
            for_each = path_rule.value.redirect != null ? [path_rule.value.redirect] : []
            content {
              path_redirect          = url_redirect.value.path_redirect
              redirect_response_code = url_redirect.value.redirect_response_code
              strip_query            = url_redirect.value.strip_query
            }
          }
        }
      }
    }
  }
}

# ========================================================================================
# BACKEND CONFIGURATION (SERVICE PROJECT)
# ========================================================================================

resource "google_compute_region_backend_service" "default" {
  # provider = google.service
  for_each = var.backends

  project               = coalesce(each.value.service_project_id, var.service_project_id)
  name                  = "${var.name}-backend"
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  protocol              = "HTTP"

  backend {
    group = "https://www.googleapis.com/compute/v1/projects/${coalesce(each.value.service_project_id, var.service_project_id)}/regions/${var.region}/networkEndpointGroups/${each.value.serverless_neg_name}"
  }

  dynamic "log_config" {
    for_each = each.value.log_config.enable ? [1] : []
    content {
      enable      = true
      sample_rate = each.value.log_config.sample_rate
    }
  }
}
