variable "name" {
  description = "Name of the resource."
  type        = string
}

variable "bucket_name" {
  type        = string
  description = "Cloud Storage bucket name."
}

variable "description" {
  type        = string
  description = "Textual description of the resource."
  default     = null
}

variable "edge_security_policy" {
  type        = string
  description = "The security policy associated with this backend bucket."
  default     = null
}

variable "custom_response_headers" {
  description = "Headers that the HTTP/S load balancer should add to proxied responses."
  default     = []
}

variable "compression_mode" {
  type        = string
  description = "Compress text responses using Brotli or gzip compression, based on the client's Accept-Encoding header. Possible values are AUTOMATIC and DISABLED."
  default     = "DISABLED"
}

variable "enable_cdn" {
  type        = bool
  description = "enable Cloud CDN for this BackendBucket."
  default     = false
}


variable "cdn_policy" {
  type = object({
    cache_mode                   = optional(string)
    signed_url_cache_max_age_sec = optional(string)
    default_ttl                  = optional(number)
    max_ttl                      = optional(number)
    client_ttl                   = optional(number)
    negative_caching             = optional(bool)
    request_coalescing           = optional(bool)
    negative_caching_policy = optional(object({
      code = optional(number)
      ttl  = optional(number)
    }))
    serve_while_stale = optional(number)
    cache_key_policy = optional(object({
      query_string_whitelist = optional(list(string))
      include_http_headers   = optional(list(string))
    }))
    bypass_cache_on_request_headers = optional(object({
      header_name = optional(string)
    }))
  })
  # default = null
}

