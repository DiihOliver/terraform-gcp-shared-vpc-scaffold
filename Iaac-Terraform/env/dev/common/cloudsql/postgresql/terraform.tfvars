/**
 * Copyright 2023 Google LLC
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

enable_postgresql_instance = true
host_project_id            = "<host-project-id>"
vpc_name                   = "dev-main-vpc-01"
project_id                 = "<service-project-id>"

/******************************************
  Details of Cloud SQL Postgresql Instance
 *****************************************/


create_timeout = "1h"
postgresql_instance = {
  postgresql_common_service_01 = {
    enable_default_db               = false
    enable_default_user             = false
    user_name                       = null
    instance_name                   = "dev-us-central1-postgresql-01"
    deletion_protection             = true
    assign_public_ip                = false ## Always be FALSE due to Org Policy
    require_ssl                     = false
    database_version                = "POSTGRES_16"
    region                          = "us-central1"
    zone                            = "us-central1-a"
    tier                            = "db-custom-2-13312"
    availability_type               = "REGIONAL" # ZONAL or REGIONAL
    disk_type                       = "PD_SSD"
    disk_size                       = 50
    disk_autoresize                 = true
    maintenance_window_hour         = null
    maintenance_window_day          = 7
    maintenance_window_update_track = "stable"
    backup_enable                   = true
    binary_log_enabled              = false ## Binary Log cannot be enabled for PostgreSQL         
    start_time                      = "18:30"
    location                        = "us-central1"
    transaction_log_retention_days  = null
    retained_backups                = null
    retention_unit                  = null
    point_in_time_recovery_enabled  = true
    associated_networks             = ["projects/<host-project-id>/global/networks/dev-main-vpc-01"]
    allocated_ip_range_name         = "dev-sql-01-psa"
    user_labels                     = {}
    # database_flags = [{
    #   name  = "cloudsql.enable_pgaudit"
    #   value = "on"
    #   },
    #   {
    #     name  = "pgaudit.log"
    #     value = "all"
    #   },
    #   {
    #     name  = "max_wal_senders"
    #     value = "30"
    #   },
    #   {
    #     name  = "cloudsql.logical_decoding"
    #     value = "on"
    #   },
    #   {
    #     name  = "max_replication_slots"
    #     value = "30"
    #   },
    # ]
  }
}
