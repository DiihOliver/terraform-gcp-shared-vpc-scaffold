/******************************************
	NAT gateway details
 *****************************************/

output "cloud_nat_name" {
  description = "Name of the Cloud NAT"
  value       = module.cloud-nat
}
