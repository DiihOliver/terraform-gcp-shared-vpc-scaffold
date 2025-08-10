/**
 * Copyright 2018 Google LLC
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

variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  type        = string
  description = "A cluster name"
  default     = ""
}
variable "is_regional" {
  type    = bool
  default = true
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
}

variable "network" {
  type        = string
  description = "The VPC network to host the cluster in"
}

variable "network_project_id" {
  type        = string
  description = "The Shared VPC network to host the cluster in"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the cluster in"
}

variable "ip_range_pods" {
  type        = string
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  type        = string
  description = "The secondary ip range to use for services"
}

variable "service_account" {
  type        = string
  description = "Service account to associate to the nodes in the cluster"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "Whether the master's internal IP address is used as the cluster endpoint"
  default     = false
}

variable "enable_private_nodes" {
  type        = bool
  description = "Whether nodes have internal IP addresses only"
  default     = true
}

variable "enable_dns_endpoint" {
  description = "(Optional) Controls whether external traffic is allowed over the dns endpoint."
  type        = bool
  default     = true
}

variable "enable_secret_manager_addon" {
  description = "Enable the Secret Manager add-on for this cluster"
  type        = bool
  default     = false
}

variable "identity_namespace" {
  description = "The workload pool to attach all Kubernetes service accounts to. (Default value of `enabled` automatically sets project-based pool `[project_id].svc.id.goog`)"
  type        = string
  default     = "enabled"
}

variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`."
  default     = "REGULAR"
}

variable "security_posture_mode" {
  description = "Security posture mode. Accepted values are `DISABLED` and `BASIC`. Defaults to `DISABLED`."
  type        = string
  default     = "DISABLED"
}

variable "default_max_pods_per_node" {
  type        = number
  description = "The maximum number of pods to schedule per node"
  default     = 110
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
  default     = false
}

variable "enable_binary_authorization" {
  type        = bool
  description = "Enable BinAuthZ Admission controller"
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to allow Terraform to destroy the cluster."
  default     = true
}

variable "gateway_api_channel" {
  type        = string
  description = "The gateway api channel of this cluster. Accepted values are `CHANNEL_STANDARD` and `CHANNEL_DISABLED`."
  default     = null
}

variable "enable_cost_allocation" {
  type        = bool
  description = "Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery"
  default     = false
}
variable "create_service_account" {
  type        = bool
  description = "Defines if service account specified to run nodes should be created."
  default     = false
}

variable "security_posture_vulnerability_mode" {
  description = "Security posture vulnerability mode. Accepted values are `VULNERABILITY_DISABLED`, `VULNERABILITY_BASIC`, and `VULNERABILITY_ENTERPRISE`. Defaults to `VULNERABILITY_DISABLED`."
  type        = string
  default     = "VULNERABILITY_DISABLED"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "(Optional) The IP range in CIDR notation to use for the hosted master network."
  default     = null
}

variable "maintenance_start_time" {
  type        = string
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format"
  default     = "05:00"
}

variable "maintenance_end_time" {
  type        = string
  description = "Time window specified for recurring maintenance operations in RFC3339 format"
  default     = ""
}

variable "maintenance_recurrence" {
  type        = string
  description = "Frequency of the recurring maintenance window in RFC5545 format."
  default     = ""
}

variable "node_pools" {
  description = "The details of node pools to be attached to the GKE cluster"
  type = list(object({
    name              = string
    min_count         = number
    max_count         = number
    machine_type      = string
    local_ssd_count   = number
    disk_size_gb      = number
    disk_type         = string
    auto_repair       = optional(bool)
    auto_upgrade      = optional(bool)
    service_account   = string
    preemptible       = bool
    max_pods_per_node = number
  }))
  default = [{
    name              = "pool-01"
    min_count         = 1
    max_count         = 100
    machine_type      = "e2-medium"
    local_ssd_count   = 0
    disk_size_gb      = 100
    disk_type         = "pd-standard"
    auto_repair       = true
    auto_upgrade      = true
    service_account   = ""
    preemptible       = false
    max_pods_per_node = 12
    }
  ]
}

variable "cluster_autoscaling" {
  type = object({
    enabled                     = bool
    autoscaling_profile         = optional(string)
    min_cpu_cores               = optional(number)
    max_cpu_cores               = optional(number)
    min_memory_gb               = optional(number)
    max_memory_gb               = optional(number)
    gpu_resources               = optional(list(object({ resource_type = string, minimum = number, maximum = number })))
    auto_repair                 = optional(bool)
    auto_upgrade                = optional(bool)
    disk_size                   = optional(number)
    disk_type                   = optional(string)
    image_type                  = optional(string)
    strategy                    = optional(string)
    max_surge                   = optional(number)
    max_unavailable             = optional(number)
    node_pool_soak_duration     = optional(string)
    batch_soak_duration         = optional(string)
    batch_percentage            = optional(number)
    batch_node_count            = optional(number)
    enable_secure_boot          = optional(bool, false)
    enable_integrity_monitoring = optional(bool, true)
  })
  default = {
    enabled                     = false
    autoscaling_profile         = "BALANCED"
    max_cpu_cores               = 10
    min_cpu_cores               = 1
    max_memory_gb               = 64
    min_memory_gb               = 1
    gpu_resources               = []
    auto_repair                 = true
    auto_upgrade                = true
    disk_size                   = 100
    disk_type                   = "pd-standard"
    image_type                  = "COS_CONTAINERD"
    enable_secure_boot          = false
    enable_integrity_monitoring = true
    max_surge                   = 1
    max_unavailable             = 0
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = {}
    default-node-pool = {}
  }
}
variable "disable_legacy_metadata_endpoints" {
  type        = bool
  description = "Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated."
  default     = true
}

variable "logging_service" {
  type        = string
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_enable_managed_prometheus" {
  type        = bool
  description = "Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled."
  default     = false
}
