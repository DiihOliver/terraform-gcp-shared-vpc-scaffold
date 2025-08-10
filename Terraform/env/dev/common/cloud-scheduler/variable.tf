variable "project_id" {
  description = "The default Google Cloud project ID to use for all resources."
  type        = string
}

variable "scheduler_jobs" {
  description = "A map of Cloud Scheduler jobs to create. The key is a logical name for the job."
  type = map(object({
    name                  = string
    region                = string
    schedule              = string
    http_method           = string
    http_uri              = string
    http_body             = optional(string, "{}")
    description           = optional(string)
    time_zone             = optional(string)
    attempt_deadline      = optional(string)
    retry_count           = optional(number)
    auth_method           = optional(string, null)
    service_account_email = optional(string)
    oidc_audience         = optional(string)
    oauth_scope           = optional(string)
  }))
  default = {}
}
