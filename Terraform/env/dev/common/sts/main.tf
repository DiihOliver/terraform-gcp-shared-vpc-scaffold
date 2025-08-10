resource "google_storage_transfer_job" "s3-bucket-backup" {
  for_each    = var.buckets_config
  name        = "transferJobs/${each.value.dest_gcs_bucket}-job"
  description = "Backup of S3 bucket:${each.value.source_s3_bucket} to GCS:${each.value.dest_gcs_bucket}"
  project     = var.project_id
  
  transfer_spec {

    dynamic "object_conditions" {
      for_each = each.value.bucket_exclusion_prefix != "" && each.value.bucket_exclusion_prefix != null ? [1] : []
      content {
        exclude_prefixes = [each.value.bucket_exclusion_prefix]
      }
    }

    aws_s3_data_source {
      bucket_name = each.value.source_s3_bucket
      role_arn    = var.s3_role_arn
    }
    gcs_data_sink {
      bucket_name = each.value.dest_gcs_bucket
    }
  }
}