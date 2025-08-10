# outputs.tf

output "scheduler_job_id" {
  description = "The full ID of the Cloud Scheduler job."
  value       = google_cloud_scheduler_job.job.id
}

output "scheduler_job_name" {
  description = "The name of the Cloud Scheduler job."
  value       = google_cloud_scheduler_job.job.name
}

output "scheduler_job_schedule" {
  description = "The schedule of the Cloud Scheduler job in cron format."
  value       = google_cloud_scheduler_job.job.schedule
}

output "scheduler_job_state" {
  description = "The state of the Cloud Scheduler job (e.g., ENABLED, PAUSED, DISABLED)."
  value       = google_cloud_scheduler_job.job.state
}

output "scheduler_job_target_uri" {
  description = "The target URI for the HTTP request."
  value       = google_cloud_scheduler_job.job.http_target[0].uri
}