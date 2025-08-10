# /*
#  * Copyright 2022 Google LLC. 
#  * 
#  * This software is provided as-is, without warranty or representation for any use or purpose. 
#  * Your use of it is subject to your agreement with Google.
#  */
resource "google_compute_region_network_endpoint_group" "default" {
  for_each = toset(var.cloud_run_service_names)

  name                  = "${var.neg-name}"
  project               = var.project
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = each.value
  }
}
