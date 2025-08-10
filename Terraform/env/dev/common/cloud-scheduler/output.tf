# outputs.tf (Root)
# Outputs the details of all created Cloud Scheduler jobs.

output "created_scheduler_jobs" {
  description = "A map of the created Cloud Scheduler jobs and their attributes."
  value = {
    for key, job in module.scheduler_jobs : key => {
      id         = job.scheduler_job_id
      name       = job.scheduler_job_name
      schedule   = job.scheduler_job_schedule
      state      = job.scheduler_job_state
      target_uri = job.scheduler_job_target_uri
    }
  }
}
