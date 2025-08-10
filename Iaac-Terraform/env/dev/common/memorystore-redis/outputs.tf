output "memorystore_instances" {
  value       = module.memorystore
  sensitive   = true
  description = "The configuration of the created MemoryStore Redis Instances"
}