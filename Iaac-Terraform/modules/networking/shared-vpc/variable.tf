variable "project_id" {
  type        = string
  description = "The project ID to deploy to"
}

variable "network" {
  description = "VPN name, only if router is not passed in and is created by the module."
  default     = ""
}

variable "subnetworks" {
  type = list(object({
    name                     = string,
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = list(string)
  }))
  default = []
}

variable "log_config_enable" {
  type        = bool
  description = "Indicates whether or not to export logs"
  default     = false
}
variable "log_config_filter" {
  type        = string
  description = "Specifies the desired filtering of logs on this NAT. Valid values are: \"ERRORS_ONLY\", \"TRANSLATIONS_ONLY\", \"ALL\""
  default     = "ALL"
}

variable "network_name" {
  type        = string
  description = "The name of the network being created"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

# variable "shared_vpc_host" {
#   type        = bool
#   description = "Makes this project a Shared VPC host if 'true' (default 'false')"
# }

variable "service_project" {
  type        = string
  description = "Service project for the shared vpc"
  default     = null
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = "vpc"
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}