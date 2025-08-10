/******************************************
	GCS Bucket configuration for Terraform State management
 *****************************************/

terraform {
  backend "gcs" {
    bucket = "prod-eu-tf-state-eu-west3-gcs"
    prefix = "gcp-deployment/terraform/env/prod/global/iam/"
  }
}
