# modules/eventarc_trigger/variables.tf

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "location" {
  description = "The location for the Eventarc trigger (e.g., asia-south1)."
  type        = string
}

variable "trigger_name" {
  description = "The name of the Eventarc trigger."
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account used by the Eventarc trigger."
  type        = string
}

variable "destination_run_service" {
  description = "The name of the Cloud Run service as the destination."
  type        = string
}

variable "destination_run_region" {
  description = "The region of the Cloud Run service."
  type        = string
}

variable "destination_run_path" {
  description = "The path on the Cloud Run service to receive events."
  type        = string
}

variable "event_filter_bucket" {
  description = "The GCS bucket name to filter events."
  type        = string
}

variable "event_filter_type" {
  description = "The type of event to filter (e.g., google.cloud.storage.object.v1.finalized)."
  type        = string
}