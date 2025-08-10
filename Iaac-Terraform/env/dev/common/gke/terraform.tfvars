/**
 * Copyright 2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Global
project_id          = "<service-project-id>"
region              = "us-central1"
is_regional         = true
network             = "dev-main-vpc-01"
network_project_id  = "<host-project-id>"
subnetwork          = "dev-gke-pvt-us-central1-subnet"
deletion_protection = true


# cluster configurations
cluster_name                        = "dev-us-central1-cluster-gke"
master_ipv4_cidr_block              = "10.1.112.0/28"
enable_private_endpoint             = true
enable_private_nodes                = true
enable_binary_authorization         = false
remove_default_node_pool            = true
gateway_api_channel                 = "CHANNEL_STANDARD"
ip_range_pods                       = "dev-gke-pod-range"
ip_range_services                   = "dev-gke-svc-range"
identity_namespace                  = "enabled"
enable_cost_allocation              = true
security_posture_mode               = "BASIC"
security_posture_vulnerability_mode = "VULNERABILITY_BASIC"
enable_secret_manager_addon         = true
release_channel                     = "REGULAR"
maintenance_start_time              = "2021-08-01T19:30:00Z"
maintenance_end_time                = "2031-08-01T23:30:00Z"
maintenance_recurrence              = "FREQ=DAILY"
service_account                     = "dev-gke-sa@<service-project-id>.iam.gserviceaccount.com"
disable_legacy_metadata_endpoints   = true
logging_service                     = "none"
cluster_autoscaling = {
  enabled            = false
  enable_secure_boot = true
}


# /******************************************
#    Nodepool Configuration & Details
# *****************************************/ 
node_pools = [
  {
    name               = "debezium-node-pool"
    auto_repair        = true
    auto_upgrade       = true
    disk_size_gb       = 100
    disk_type          = "pd-balanced"
    local_ssd_count    = 0
    machine_type       = "e2-standard-4"
    min_count          = 1
    max_count          = 3
    max_pods_per_node  = 110
    max_surge          = 1
    max_unavailable    = 1
    node_count         = 1
    initial_node_count = 1
    preemptible        = false
    service_account    = "dev-gke-sa@<service-project-id>.iam.gserviceaccount.com"
  }
]

node_pools_labels = { // refer this https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/22712d49ce105c9a18b48cd0a79bb4c15d07844c/examples/node_pool/main.tf#L120
  debezium-node-pool = {
    purpose     = "debezium-cluster",
    environment = "dev"
  }
}
