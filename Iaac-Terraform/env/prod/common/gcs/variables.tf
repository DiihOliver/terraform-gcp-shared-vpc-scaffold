variable "project_id" {
  description = "GCP Project ID in which the resource will be provisioned."
  type        = string
  default     = ""
}


variable "gcs_bucket" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    app_name           = string,
    location           = string,
    versioning         = bool,
    storage_class      = string,
    bucket_policy_only = bool,
    force_destroy      = bool,
    enable_neg         = bool,
    neg_default_port   = optional(string),
    port               = optional(string),
    labels             = map(string),
    data_locations     = list(string),
    retention_policy = object({
      is_locked        = bool
      retention_period = number
    })
    iam_members = optional(list(object({
      role   = string
      member = string
    })), [])
  }))
}
