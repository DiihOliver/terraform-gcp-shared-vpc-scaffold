variable "host_project_id" {
  type        = string
  description = "The project ID of the Shared VPC host project."
}

variable "service_project_id" {
  type        = string
  description = "The project ID of the service project where the NEG resides."
}

variable "name" {
  description = "A unique name for the load balancer instance."
  type        = string
}

variable "prefix" {
  description = "A prefix for all resource names."
  type        = string
}

variable "backend_config" {
  description = "Configuration for the Serverless NEG backend."
  type = object({
    neg_name = string
    region   = string
  })
}

variable "backend_buckets" {
  description = "A map of backend bucket configurations to be used for path-based routing. The key is a logical name for the bucket."
  type = map(object({
    bucket_name  = string
    paths        = list(string)
    enable_cdn   = optional(bool, false)
    description  = optional(string, null)
  }))
  default = {}
}

variable "certificate_map_name" {
  description = "The name of the Google Cloud Certificate Map that contains the desired certificate."
  type        = string
}

variable "routing_rules" {
  description = "A list of routing rules for host and path-based redirects. If empty, all traffic goes to the default backend."
  type = list(object({
    hostnames = list(string)
    path_redirects = list(object({
      source_paths  = list(string)
      redirect_path = string
    }))
  }))
  default = []
}

variable "create_static_ip" {
  description = "If true, a new global static IP address will be created."
  type        = bool
  default     = true
}

variable "existing_static_ip_address" {
  description = "The self-link of an existing global static IP address to use when create_static_ip is false."
  type        = string
  default     = null
}

variable "enable_http_to_https_redirect" {
  description = "If true, creates the forwarding rule and proxy for port 80 to redirect to HTTPS."
  type        = bool
  default     = true
}

variable "enable_cdn" {
  description = "If true, enables Cloud CDN for the backend service."
  type        = bool
  default     = false
}

variable "ssl_policy" {
  description = "The self-link of an SSL Policy to attach to the HTTPS proxy."
  type        = string
  default     = null
}
