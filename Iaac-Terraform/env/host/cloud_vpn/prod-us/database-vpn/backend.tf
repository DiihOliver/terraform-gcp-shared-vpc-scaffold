terraform {
  backend "gcs" {
    bucket = "host-tf-state-us-central1-gcs"
    prefix = "gcp-deployment/terraform/env/host/cloud_vpn/prod/database-vpn"
  }
}