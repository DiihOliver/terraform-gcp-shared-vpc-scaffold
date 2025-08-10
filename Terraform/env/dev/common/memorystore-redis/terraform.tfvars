/******************************************
  Details of  MemoryStore Instance
 *****************************************/
project_id                  = "<service-project-id>"
vpc_name                    = "projects/<host-project-id>/global/networks/dev-main-vpc-01"

redis_instances_config = {
  redis_01 = {
    instance_name           = "redis-app"
    tier                    = "BASIC"
    memory_size_gb          = 4
    redis_version           = "REDIS_5_0"
    connect_mode            = "PRIVATE_SERVICE_ACCESS"
    replica_count           = 1
    read_replicas_mode      = "READ_REPLICAS_DISABLED"
    auth_enabled            = false
    transit_encryption_mode = "DISABLED"
    reserved_ip_range       = "dev-redis-01-psa"

    maintenance_policy = {
      day        = "SATURDAY"
      start_time = {
        hours   = 0
        minutes = 0
        seconds = 0
        nanos   = 0
      }
    }
    labels = {
      env         = "dev"
      app         = "redis-app"
      created_by  = "terraform"
    }
    region                  = "us-central1"
    location_id             = "us-central1-a"
  },
}
