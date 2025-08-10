terraform {
  backend "gcs" {
    bucket = "dev-tf-state-us-central1-gcs"
    prefix = "gcp-deployment/terraform/env/dev/common/private-dns-zone"
  }
}