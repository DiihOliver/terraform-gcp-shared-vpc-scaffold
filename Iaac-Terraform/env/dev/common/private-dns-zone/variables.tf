/******************************************
    GCP Private DNS Zone Variables
 *****************************************/

variable "host_project_id" {
  type        = string
  description = "The project ID of host/management project."
  nullable    = false
}

variable "svc_project_id" {
  type        = string
  description = "The project ID of service project."
  nullable    = false
}

variable "vpc_name" {
  type = string
  nullable = false
}

variable "redis_dns_config" {
  type = map(object({
    redis_dns_name = string
    redis_ipv4_address = string
  }))
}