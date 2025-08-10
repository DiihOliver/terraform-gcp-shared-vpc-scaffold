terraform {
  backend "gcs" {
    bucket = "dev-tf-state-us-central1-gcs"
    prefix = "gcp-deployment/terraform/env/dev/apps/app-02"
  }
}