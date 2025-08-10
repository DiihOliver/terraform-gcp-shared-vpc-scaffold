output "id" {
  description = "Backend Bucket resource."
  value       = google_compute_backend_bucket.backend.id
}

output "self_link" {
  description = "Backend Bucket resource."
  value       = google_compute_backend_bucket.backend.self_link
}