data "google_compute_network" "my-network" {
  project = var.host_project_id
  name    = var.vpc_name
}

/******************************************
  Details of Cloud SQL Instance
 *****************************************/
module "postgresql_instance" {
  source                          = "../../../../../modules/cloudsql/postgresql"
  project_id                      = var.project_id
  for_each                        = var.enable_postgresql_instance ? var.postgresql_instance : {}
  name                            = each.value.instance_name
  user_name                       = each.value.user_name
  deletion_protection             = each.value.deletion_protection
  deletion_protection_enabled     = each.value.deletion_protection_enabled
  enable_default_db               = each.value.enable_default_db
  enable_default_user             = each.value.enable_default_user
  database_version                = each.value.database_version
  region                          = each.value.region
  zone                            = each.value.zone
  tier                            = each.value.tier
  availability_type               = each.value.availability_type
  disk_size                       = each.value.disk_size
  disk_type                       = each.value.disk_type
  disk_autoresize                 = each.value.disk_autoresize
  maintenance_window_day          = each.value.maintenance_window_day
  maintenance_window_hour         = each.value.maintenance_window_hour
  maintenance_window_update_track = each.value.maintenance_window_update_track
  user_labels                     = each.value.user_labels
  database_flags                  = each.value.database_flags
  create_timeout                  = var.create_timeout
  ip_configuration = {
    ipv4_enabled        = each.value.assign_public_ip
    require_ssl         = each.value.require_ssl
    private_network     = data.google_compute_network.my-network.self_link
    allocated_ip_range  = each.value.allocated_ip_range_name
    associated_networks = []
  }

  backup_configuration = {
    enabled                        = each.value.backup_enable
    binary_log_enabled             = each.value.binary_log_enabled
    start_time                     = each.value.start_time
    location                       = each.value.location
    transaction_log_retention_days = each.value.transaction_log_retention_days
    retained_backups               = each.value.retained_backups
    retention_unit                 = each.value.retention_unit
    point_in_time_recovery_enabled = each.value.point_in_time_recovery_enabled
  }
}
