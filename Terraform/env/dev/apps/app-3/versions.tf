terraform {
  required_version = ">= 1.12.0"
  required_providers {
    google      = ">= 6.41.0"
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5.6"
    }
  }
}