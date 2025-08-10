variable "host_project_id" {
  description = "The ID of the host project."
  type        = string
}

variable "service_project_id" {
  description = "The default ID of the service project. Can be overridden per backend."
  type        = string
}

variable "name" {
  description = "A base name for all the load balancer resources."
  type        = string
}

variable "region" {
  description = "The Google Cloud region for the load balancer."
  type        = string
}

variable "network_self_link" {
  description = "The self-link of the VPC network."
  type        = string
}

variable "subnet_self_link" {
  description = "The self-link of the subnet where the internal IP address will be allocated."
  type        = string
}

variable "proxy_subnet_self_link" {
  description = "The self-link of the regional proxy-only subnet."
  type        = string
}

variable "certificate_names" {
  description = "The name of the Certificate Manager map in the host project."
  type        = list(string)
  default     = []
}


variable "backends" {
  description = "A map of backend services to create. The key is a logical name used in routing_rules."
  type = map(object({
    service_project_id  = optional(string)
    serverless_neg_name = string
    log_config = optional(object({
      enable      = bool
      sample_rate = number
      }), {
      enable      = false
      sample_rate = 1.0
    })
  }))
}

variable "int_lb_routing_rules" {
  description = "A list of host rules and their associated path matching rules."
  type = list(object({
    hosts        = list(string)
    path_matcher = string
    paths = list(object({
      paths   = list(string)
      backend = optional(string)
      redirect = optional(object({
        path_redirect          = string
        redirect_response_code = optional(string, "MOVED_PERMANENTLY_DEFAULT")
        strip_query            = optional(bool, false)
      }))
    }))
  }))
  default = []
}

variable "int_create_address" {
  description = "If true, a new static internal IP address is created. If false, specify either 'existing_address_name' or a literal 'address'."
  type        = bool
}

# NEW: Variable to accept the name of an existing address resource.
variable "int_address_name" {
  description = "The name of an existing 'google_compute_address' to use when 'create_address' is false."
  type        = string
  default     = null
}

variable "address" {
  description = "A literal IP address string. Used as a fallback only when 'create_address' is false and 'existing_address_name' is not provided."
  type        = string
  default     = ""
}


variable "enable_http_to_https_redirect" {
  description = "If true, create a parallel HTTP frontend to redirect traffic to HTTPS."
  type        = bool
}

variable "labels" {
  description = "A map of labels to apply to the forwarding rules."
  type        = map(string)
}