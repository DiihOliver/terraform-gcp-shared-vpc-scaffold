variable "project_id" {
  type        = string
  description = "The project to setup cloudsql mysql on"
}

variable "vpc_network" {
  description = "Name of the VPC network to peer."
  type        = string
}

variable "region" {
  type        = string
  description = "The region to setup cloudsql mysql in"
}

variable "mysql_instance" {
  type = map(object({
    instance_name                   = string
    deletion_protection             = bool
    database_version                = string
    enable_default_db               = optional(string, false)
    region                          = string
    zone                            = string
    tier                            = string
    availability_type               = string
    disk_type                       = string
    disk_size                       = number
    maintenance_window_hour         = number
    maintenance_window_day          = number
    maintenance_window_update_track = string
    private_network                 = string
    allocated_ip_range              = string
    user_labels                     = map(any)
    database_flags = list(object({
      name  = string
      value = string
    }))
    transaction_log_retention_days = string
  }))
  default = {
    mysql = {
      instance_name                   = ""
      deletion_protection             = true
      database_version                = ""
      enable_default_db               = false
      region                          = ""
      zone                            = ""
      tier                            = ""
      availability_type               = "REGIONAL"
      disk_type                       = "PD_SSD"
      disk_size                       = 10
      maintenance_window_hour         = 12
      maintenance_window_day          = 7
      maintenance_window_update_track = "stable"
      transaction_log_retention_days  = 7
      private_network                 = ""
      allocated_ip_range              = ""
      user_labels                     = {}
      database_flags                  = null
    }
  }
}
