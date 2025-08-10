terraform {
  required_version = ">= 1.6.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.42.0, < 7"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.42.0, < 7"
    }
  }
}
