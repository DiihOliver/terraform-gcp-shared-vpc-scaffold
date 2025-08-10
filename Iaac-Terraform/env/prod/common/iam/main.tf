module "custom_roles" {
  for_each = {
    for key, config in var.service_account_configs : key => config if config.custom_role_id != null
  }
  source      = "../../../../modules/iam/custom-role"
  project     = var.project_id
  role_id     = each.value.custom_role_id
  permissions = each.value.custom_role_permissions
}

module "service_accounts" {
  for_each = var.service_account_configs

  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = each.value.service_account_name
}

module "member_roles" {
  for_each = var.service_account_configs

  source                  = "../../../../modules/iam/member-iam"
  project                 = var.project_id
  service_account_address = module.service_accounts[each.key].email
  project_roles           = each.value.project_level_roles
  depends_on              = [module.custom_roles, module.service_accounts]
}

/******************************************
  Module for Audit SA
 *****************************************/

module "member_roles_audit" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = "auditor-pr-04788-sa@gcp-auditor.iam.gserviceaccount.com" // Just for auditing purpose for Searce's side. It will be removed after handover
  project                 = var.project_id
  project_roles           = ["roles/cloudsql.viewer", "roles/storage.objectViewer", "roles/compute.viewer", "roles/iam.securityReviewer", "roles/cloudfunctions.viewer", "roles/run.viewer"]
}