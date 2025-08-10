# /*
#  * Copyright 2022 Google LLC. 
#  * 
#  * This software is provided as-is, without warranty or representation for any use or purpose. 
#  * Your use of it is subject to your agreement with Google.
#  */
output "neg_ids" {
  description = "Map of network endpoint group IDs by Cloud Run service name"
  value = { for name, neg in google_compute_region_network_endpoint_group.default : name => neg.id }
}
