resource "random_password" "mysql_root_password" {
  for_each         = var.mysql_instance
  length           = 12 # You can adjust the length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
module "mysql" {
  source              = "../../../../../modules/cloudsql/mysql"
  project_id          = var.project_id
  for_each            = var.mysql_instance
  name                = each.value.instance_name
  database_version    = each.value.database_version
  region              = each.value.region
  deletion_protection = each.value.deletion_protection
  enable_default_db   = each.value.enable_default_db

  // Master configurations
  tier                            = each.value.tier
  zone                            = each.value.zone
  availability_type               = each.value.availability_type
  disk_size                       = each.value.disk_size
  disk_type                       = each.value.disk_type
  maintenance_window_day          = each.value.maintenance_window_day
  maintenance_window_hour         = each.value.maintenance_window_hour
  maintenance_window_update_track = each.value.maintenance_window_update_track

  ip_configuration = {
    ipv4_enabled       = false
    private_network    = each.value.private_network
    allocated_ip_range = each.value.allocated_ip_range
  }

  backup_configuration = {
    enabled                        = true
    binary_log_enabled             = true
    start_time                     = "00:00"
    transaction_log_retention_days = each.value.transaction_log_retention_days
  }

  database_flags = each.value.database_flags

  user_labels   = each.value.user_labels
  root_password = random_password.mysql_root_password[each.key].result
}
