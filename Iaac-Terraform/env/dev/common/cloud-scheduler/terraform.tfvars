project_id = "<service-project-id>"

scheduler_jobs = {
  "demo-job" = {
    name                  = "demo-job"
    region                = "us-central1"
    description           = "Triggers the invoice processing service every 15 minutes."
    schedule              = "*/15 * * * *"
    http_method           = "POST"
    http_uri              = "https://google.com/"
    time_zone             = "America/New_York"
    # auth_method           = "OAUTH"
    # service_account_email = "<sa-name>@<service-project-id>.iam.gserviceaccount.com"
    # oauth_scope           = "https://www.googleapis.com/auth/cloud-platform"
  }
}
