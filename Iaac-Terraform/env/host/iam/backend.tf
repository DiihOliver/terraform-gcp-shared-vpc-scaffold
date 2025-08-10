/******************************************
	GCS Bucket configuration for Terraform State management
 *****************************************/

terraform {
  backend "gcs" {
    bucket = "host-tf-state-us-central1-gcs"
    prefix = "gcp-deployment/terraform/env/host/global/iam/service_accounts"
  }
}