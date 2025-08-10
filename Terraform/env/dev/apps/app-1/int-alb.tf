# ----------------------------------------------------------------------------------------
# REGIONAL INTERNAL APPLICATION LOAD BALANCER
# ----------------------------------------------------------------------------------------
module "regional_internal_lb" {
  source = "../../../../modules/networking/loadbalancer/reg-int-lb"
  name   = var.int_lb_name
  region = var.region
  labels = var.labels

  # Host Project Configuration
  host_project_id        = var.host_project_id
  network_self_link      = "projects/${var.host_project_id}/global/networks/${var.network_name}"
  subnet_self_link       = "projects/${var.host_project_id}/regions/${var.region}/subnetworks/${var.subnet_name}"
  proxy_subnet_self_link = "projects/${var.host_project_id}/regions/${var.region}/subnetworks/${var.proxy_subnet_name}"
  certificate_names      = keys(var.int_certificates)

  # Service Project Configuration
  service_project_id            = var.service_project_id
  backends                      = var.backends
  int_lb_routing_rules          = var.int_lb_routing_rules
  enable_http_to_https_redirect = true
  int_create_address            = true
  depends_on                    = [module.cr_negs]
}
