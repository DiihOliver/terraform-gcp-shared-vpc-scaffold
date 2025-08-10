module "memorystore" {
  source                  = "../../../../modules/memorystore-redis"
  project                 = var.project_id
  authorized_network      = var.vpc_name
  for_each                = var.redis_instances_config
  // Configurations      
  name                    = each.value.instance_name
  tier                    = each.value.tier
  replica_count           = each.value.replica_count
  read_replicas_mode      = each.value.read_replicas_mode
  memory_size_gb          = each.value.memory_size_gb
  connect_mode            = each.value.connect_mode
  redis_version           = each.value.redis_version
  labels                  = each.value.labels
  auth_enabled            = each.value.auth_enabled
  transit_encryption_mode = each.value.transit_encryption_mode
  maintenance_policy      = each.value.maintenance_policy
  reserved_ip_range       = each.value.reserved_ip_range

  // Networking
  region                  = each.value.region
  location_id             = each.value.location_id
}