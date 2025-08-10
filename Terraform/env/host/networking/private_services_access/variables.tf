/******************************************
  Variables for Private Service Access
 *****************************************/

variable "project_id" {
  description = "The project ID of the VPC network to peer. This can be a shared VPC host projec."
  type        = string
}

variable "psa_config" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    project_id    = optional(string),
    vpc_network   = string,
    psa_name      = string,
    region        = optional(string),
    vpc_address   = string,
    prefix_length = number,
    create_connection = bool
  }))
}
