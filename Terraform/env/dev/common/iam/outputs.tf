/******************************************
  Outputs of service_account emails
 *****************************************/
output "service_account_gke_email" {
  value = module.service_account_gke.email
}

output "service_account_mgmt_email" {
  value = module.service_account_mgmt.email
}

output "service_account_cr_email" {
  value = module.service_account_cr.email
}

output "service_account_cf_email" {
  value = module.service_account_cf.email
}

output "service_account_postgre_email" {
  value = module.service_account_postgre.email
}

output "service_account_amplitude_email" {
  value = module.service_account_amplitude.email
}

output "service_account_emails" {
  description = "A list of the created Service Account Emails"
  value       = [for sa in module.service_accounts : sa.email]
}

output "custom_roles" {
  description = "A list of the created Custom role IDs"
  value       = [for role in module.custom_roles : role.custom_role_id]
}
