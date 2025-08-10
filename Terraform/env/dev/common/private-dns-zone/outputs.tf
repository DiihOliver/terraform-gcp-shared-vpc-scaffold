output "private_zone_details" {
  value       = google_dns_managed_zone.private-zone
  description = "The details of the GCP Private Zone"
}
