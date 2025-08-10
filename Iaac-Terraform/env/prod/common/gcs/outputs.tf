output "gcs_buckets" {
  description = "A list of the created GCS Buckets"
  value       = [for bucket in module.gcs_bucket : bucket.bucket_id]
}