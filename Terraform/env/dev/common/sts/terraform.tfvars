project_id = "<service-project-id>"
s3_role_arn   = "arn:aws:iam::<arn>:role/TransferS3AccessRoleStaging"


buckets_config = {
  app-bucket = {
    source_s3_bucket      = "app-bucket",
    dest_gcs_bucket       = "gcp-app-bucket"
    # bucket_exclusion_prefix = ""
  },
  package-files-bucket = {
    source_s3_bucket      = "package-files-bucket",
    dest_gcs_bucket       = "gcp-package-files-bucket"
    # bucket_exclusion_prefix = ""
  },
  static-asset-bucket = {
    source_s3_bucket      = "static-asset-bucket",
    dest_gcs_bucket       = "gcp-static-asset-bucket"
    # bucket_exclusion_prefix = ""
  },
}