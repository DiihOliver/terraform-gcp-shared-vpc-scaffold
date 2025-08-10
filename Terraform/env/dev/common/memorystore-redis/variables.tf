variable "org" {
  description = "The name of the Organisation"
  type        = string
  default     = ""
}

# variable "network_project_id" {
#   type        = string
#   description = "The project ID of the shared VPC's host (for shared vpc support)"
#   default     = ""
# }

variable "project_id" {
  description = "GCP Project ID in which the resource will be provisioned."
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Selflink of the VPC Network associated with the SQL instance."
  type        = string
  default     = ""
}
/******************************************
  Variables for MemoryStore Instance
 *****************************************/

variable "enable_memorystore_creation" {
  description = "enable memorystore creation"
  type        = bool
  default     = false
}

variable "redis_instances_config" {
  type = map(object({
    instance_name                = string,
    region                  = string,
    tier                    = string,
    memory_size_gb          = string,
    location_id             = string,
    alternative_location_id = optional(string),
    redis_version           = string,
    connect_mode            = string,
    replica_count           = number,
    read_replicas_mode      = string,
    auth_enabled            = bool
    transit_encryption_mode = optional(string),
    labels                  = map(string),
    reserved_ip_range = string
    maintenance_policy = object({
      day = string
      start_time = object({
        hours   = number,
        minutes = number,
        seconds = number,
        nanos   = number,
      })
    })
  }))
  nullable = false
}
