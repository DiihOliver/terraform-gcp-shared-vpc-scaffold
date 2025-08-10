terraform {
  backend "gcs" {
    bucket = "dev-tf-state-us-central1-gcs"
    prefix = "gcp-deployment/terraform/env/dev/regions/us-central1/gke/"
  }
}