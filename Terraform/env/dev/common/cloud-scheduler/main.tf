module "scheduler_jobs" {
  source   = "../../../../modules/cloud-scheduler"
  for_each = var.scheduler_jobs

  project_id            = var.project_id
  job_name              = each.value.name
  region                = each.value.region
  schedule              = each.value.schedule
  time_zone             = lookup(each.value, "time_zone", null)
  http_method           = each.value.http_method
  http_uri              = each.value.http_uri
  http_body             = lookup(each.value, "http_body", null)
  auth_method           = lookup(each.value, "auth_method", null)
  service_account_email = lookup(each.value, "service_account_email", null)
  oidc_audience         = lookup(each.value, "oidc_audience", null)
  oauth_scope           = lookup(each.value, "oauth_scope", null)
  description           = lookup(each.value, "description", null)
  attempt_deadline      = lookup(each.value, "attempt_deadline", null)
  retry_count           = lookup(each.value, "retry_count", null)
}
