resource "google_cloud_scheduler_job" "job" {
  project          = var.project_id
  region           = var.region
  name             = var.job_name
  description      = var.description
  schedule         = var.schedule
  time_zone        = var.time_zone
  attempt_deadline = var.attempt_deadline

  retry_config {
    retry_count          = var.retry_count
    max_retry_duration   = var.max_retry_duration
    min_backoff_duration = var.min_backoff_duration
    max_backoff_duration = var.max_backoff_duration
    max_doublings        = var.max_doublings
  }

  http_target {
    http_method = var.http_method
    uri         = var.http_uri
    body        = contains(["POST", "PUT", "PATCH"], var.http_method) ? base64encode(var.http_body) : null
    headers = {
      "Content-Type" = "application/json"
    }
    dynamic "oauth_token" {
      for_each = var.auth_method == "OAUTH" && var.service_account_email != null ? [1] : []
      content {
        service_account_email = var.service_account_email
        scope                 = var.oauth_scope
      }
    }

    dynamic "oidc_token" {
      for_each = var.auth_method == "OIDC" && var.service_account_email != null ? [1] : []
      content {
        service_account_email = var.service_account_email
        audience              = var.oidc_audience
      }
    }
  }
}
