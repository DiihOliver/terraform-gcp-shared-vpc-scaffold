# ------------------------------------------------------------------------------
# sts variables
# ------------------------------------------------------------------------------

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "s3_role_arn" {
  description = "The Role ARN of AWS S3 Role"
  type        = string
}

variable "buckets_config" {
  type = map(object({
    source_s3_bucket        = string,
    dest_gcs_bucket         = string,
    bucket_exclusion_prefix = optional(string)
  }))
  default = null
}