/******************************************
  Providers Variables
 *****************************************/

variable "host_project_id" {
  description = "Host Project ID."
  type        = string
}

variable "service_project_ids" {
  type        = list(string)
  description = "List of Service Project IDs"
  default = ["shared-vpc-service"]

}


/*********************************************************
 VPC, Subnets, PrivateServiceAccess and Cloud NAT Variable
 *********************************************************/

variable "svc_project_networking" {
  description = "The GKE cluster name, node pool  and metadata list for the Service project's GKE."
  type = map(object({
    network_name                     = string
    routing_mode                     = string
    subnets                          = list(map(string))
    secondary_ranges                 = map(list(object({ range_name = string, ip_cidr_range = string })))
  }))
}

variable "service_project_subnet_sharing" {
  description = "A map where keys are service project IDs. The value is another map where keys are subnet self-links and values are the custom service account emails to be granted access."
  type        = map(map(list(string)))
  default     = {}
}
