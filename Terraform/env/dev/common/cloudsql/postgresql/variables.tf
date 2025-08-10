/**
 * Copyright 2023 Google LLC
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
 */

variable "host_project_id" {
  description = "GCP Project ID of the Shared VPC host project."
  type        = string
}

variable "vpc_name" {
  description = "The name of the Shared VPC network in the host project."
  type        = string
}

variable "project_id" {
  description = "GCP Project ID in which the Cloud SQL resource will be provisioned (your service project)."
  type        = string
}

/******************************************
    Variables for Postgresql
  *****************************************/

variable "create_timeout" {
  description = "Timeout for instance creation."
  type        = string
  default     = "30m"
}

variable "enable_postgresql_instance" {
  description = "Enable Postgresql instance creation."
  type        = bool
  default     = false
}

variable "postgresql_instance" {
  type = map(object({
    instance_name                   = string
    deletion_protection             = bool
    deletion_protection_enabled     = optional(bool, true)
    database_version                = string
    region                          = string
    zone                            = string
    tier                            = string
    assign_public_ip                = bool
    require_ssl                     = bool
    availability_type               = string
    disk_type                       = string
    disk_size                       = number
    disk_autoresize                 = bool
    maintenance_window_hour         = number
    maintenance_window_day          = number
    maintenance_window_update_track = string
    user_labels                     = map(string)
    database_flags = list(object({
      name  = string
      value = string
    }))
    backup_enable                  = bool
    binary_log_enabled             = bool
    start_time                     = string
    location                       = string
    transaction_log_retention_days = string
    retained_backups               = number
    retention_unit                 = string
    point_in_time_recovery_enabled = bool
    allocated_ip_range_name        = string
    enable_default_db              = bool
    enable_default_user            = bool
    user_name                      = string
  }))
  default = {
    postgresql = {
      instance_name                   = ""
      deletion_protection             = true
      deletion_protection_enabled     = true
      database_version                = ""
      region                          = ""
      zone                            = ""
      tier                            = ""
      assign_public_ip                = false
      require_ssl                     = false
      availability_type               = "REGIONAL"
      disk_type                       = "PD_SSD"
      disk_size                       = 10
      disk_autoresize                 = false
      maintenance_window_hour         = 12
      maintenance_window_day          = 7
      maintenance_window_update_track = "stable"
      location                        = "us-central1"
      transaction_log_retention_days  = 7
      retained_backups                = 7
      retention_unit                  = null
      backup_enable                   = true
      binary_log_enabled              = false
      point_in_time_recovery_enabled  = false
      start_time                      = ""
      user_labels                     = {}
      database_flags                  = []
      allocated_ip_range_name         = null
      enable_default_db               = false
      enable_default_user             = false
      user_name                       = "postgres"
    }
  }
}
