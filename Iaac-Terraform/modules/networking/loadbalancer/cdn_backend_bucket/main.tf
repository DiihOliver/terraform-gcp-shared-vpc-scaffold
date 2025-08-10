resource "google_compute_backend_bucket" "backend" {
  name                    = var.name
  description             = var.description
  bucket_name             = var.bucket_name
  edge_security_policy    = var.edge_security_policy
  custom_response_headers = var.custom_response_headers
  compression_mode        = var.compression_mode
  enable_cdn              = var.enable_cdn

  dynamic "cdn_policy" {
    for_each = var.enable_cdn ? [1] : []
    content {
      cache_mode                   = var.cdn_policy["cache_mode"]
      signed_url_cache_max_age_sec = var.cdn_policy["signed_url_cache_max_age_sec"]
      default_ttl                  = var.cdn_policy["default_ttl"]
      max_ttl                      = var.cdn_policy["max_ttl"]
      client_ttl                   = var.cdn_policy["client_ttl"]
      negative_caching             = var.cdn_policy["negative_caching"]
      serve_while_stale            = var.cdn_policy["serve_while_stale"]
      request_coalescing           = var.cdn_policy["request_coalescing"]

      dynamic "cache_key_policy" {
        for_each = var.cdn_policy["cache_key_policy"] != null ? [1] : []
        content {
          query_string_whitelist = var.cdn_policy["cache_key_policy"]["query_string_whitelist"]
          include_http_headers   = var.cdn_policy["cache_key_policy"]["include_http_headers"]
        }
      }

      dynamic "negative_caching_policy" {
        for_each = var.cdn_policy["negative_caching_policy"] != null ? [1] : []
        content {
          code = var.cdn_policy["negative_caching_policy"]["code"]
          ttl  = var.cdn_policy["negative_caching_policy"]["ttl"]
        }
      }

      dynamic "bypass_cache_on_request_headers" {
        for_each = var.cdn_policy["bypass_cache_on_request_headers"] != null ? [1] : []
        content {
          header_name = var.cdn_policy["bypass_cache_on_request_headers"]["header_name"]
        }
      }
    }
  }
}
