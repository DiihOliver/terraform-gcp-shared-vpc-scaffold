/******************************************
	Module for Secret Manager
 *****************************************/

module "secret-manager" {
  source     = "../../../../modules/secret-manager"
  for_each   = var.secret_manager
  project_id = var.project_id
  name       = each.value.id
  labels     = each.value.labels
}
