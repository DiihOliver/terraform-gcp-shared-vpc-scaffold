# variables.tf

variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "region" {
  description = "The region where the resource will be deployed."
  type        = string
}

variable "job_name" {
  description = "The name of the Cloud Scheduler job."
  type        = string
}

variable "description" {
  description = "A human-readable description for the job."
  type        = string
  default     = "Cloud Scheduler job managed by Terraform"
}

variable "schedule" {
  description = "The schedule in cron format (e.g., '*/8 * * * *')."
  type        = string
}

variable "time_zone" {
  description = "The time zone for the schedule (e.g., 'America/New_York')."
  type        = string
  default     = "Etc/UTC"
}

variable "attempt_deadline" {
  description = "The deadline for job attempts. If the job does not complete by this deadline, it will be cancelled."
  type        = string
  default     = "300s" # 5 minutes
}

variable "retry_count" {
  description = "The number of times to retry a failed job."
  type        = number
  default     = 3
}

variable "max_retry_duration" {
  description = "The maximum time to retry a job."
  type        = string
  default     = null
}

variable "min_backoff_duration" {
  description = "The minimum duration to wait before retrying a job."
  type        = string
  default     = "5s"
}

variable "max_backoff_duration" {
  description = "The maximum duration to wait before retrying a job."
  type        = string
  default     = "3600s" # 1 hour
}

variable "max_doublings" {
  description = "The number of times to double the backoff duration."
  type        = number
  default     = 16
}

variable "http_method" {
  description = "The HTTP method to use for the target (e.g., 'GET', 'POST', 'PUT')."
  type        = string
  default     = "GET"
}

variable "http_uri" {
  description = "The URI of the HTTP target."
  type        = string
}

variable "http_body" {
  description = "The body of the HTTP request for POST, PUT, or PATCH methods. Should be a JSON string."
  type        = string
  default     = "{}"
}

variable "auth_method" {
  description = "The authentication method to use ('OAUTH', 'OIDC', or null for none)."
  type        = string
  default     = null
}

variable "service_account_email" {
  description = "The service account email to use for OAUTH or OIDC authentication."
  type        = string
  default     = null
}

variable "oauth_scope" {
  description = "The scope to use for OAUTH authentication."
  type        = string
  default     = null
}

variable "oidc_audience" {
  description = "The audience to use for OIDC authentication."
  type        = string
  default     = null
}