terraform {
  backend "gcs" {
    bucket = "host-tf-state-us-central1-gcs" # add tfstate bucket name here
    prefix = "gcp-deployment/terraform/env/host/global/cloud_vpn/database"
  }
}