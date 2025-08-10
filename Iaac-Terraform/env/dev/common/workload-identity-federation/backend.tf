/******************************************
	GCS Bucket configuration for Terraform State management
 *****************************************/

terraform {
  backend "gcs" {
    bucket = "dev-tf-state-us-central1-gcs"
    prefix = "gcp-deployment/terraform/env/dev/global/workload-identity-federation"
  }
}
