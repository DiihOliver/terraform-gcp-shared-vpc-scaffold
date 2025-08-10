output "instance_self_link" {
  value       = module.mysql
  sensitive   = true
  description = "The URI of the master instance"
}