resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  project                 = var.project_id
  description             = var.description
}

module "host_prj_svpc_subnets" {
  source           = "../subnet"
  project_id       = var.project_id
  network_name     = google_compute_network.network.self_link
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}
