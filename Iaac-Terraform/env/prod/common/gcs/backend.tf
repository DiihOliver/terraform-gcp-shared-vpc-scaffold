terraform {
  backend "gcs" {
    bucket = "prod-eu-tf-state-eu-west3-gcs"
    prefix = "gcp-deployment/terraform/env/prod-eu/common/gcs"
  }
}