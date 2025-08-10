# modules/eventarc_trigger/main.tf

resource "google_eventarc_trigger" "gh" {
  project  = var.project_id
  location = var.location
  name     = var.trigger_name

  service_account = var.service_account_email

  destination {
    cloud_run_service {
      service = var.destination_run_service
      region  = var.destination_run_region
      path    = var.destination_run_path
    }
  }

  matching_criteria {
    attribute = "bucket"
    value     = var.event_filter_bucket
  }

  matching_criteria {
    attribute = "type"
    value     = var.event_filter_type
  }
}

output "trigger_id" {
  description = "The ID of the Eventarc trigger."
  value       = google_eventarc_trigger.gh.id
}