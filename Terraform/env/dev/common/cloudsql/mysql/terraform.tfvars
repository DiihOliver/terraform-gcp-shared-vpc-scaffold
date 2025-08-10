project_id  = "<service-project-id>"
vpc_network = "dev-main-vpc-01"
region      = "us-central1"

mysql_instance = {
  mysql_01 = {
    region            = "us-central1"
    instance_name     = "dev-us-central1-mysql-01"
    tier              = "db-custom-2-13312"
    zone              = "us-central1-a"
    availability_type = "REGIONAL"
    deletion_protection             = true
    database_version                = "MYSQL_8_0"
    disk_size                       = "50"
    disk_type                       = "PD_SSD"
    private_network                 = "projects/<host-project-id>/global/networks/dev-main-vpc-01"
    allocated_ip_range              = "dev-sql-01-psa"
    maintenance_window_day          = "7"
    maintenance_window_hour         = "12"
    maintenance_window_update_track = "stable"
    transaction_log_retention_days  = "7"
    database_flags                  = []
    user_labels = {
      environment = "dev"
      purpose     = "dev-mysql"
      region      = "us-central1"
    }
    immutable_tags = true
  }
}
