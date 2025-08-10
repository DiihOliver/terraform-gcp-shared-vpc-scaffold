output "artifact_registry_details" {
  value       = module.artifact_registry["repo_01"].repo_name
  description = "The details of the Artifact Registry"
}
