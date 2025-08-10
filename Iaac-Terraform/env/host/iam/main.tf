/******************************************
  Module for Terraform Deployment
 *****************************************/
 
data "google_service_account" "terraform" {
  account_id = var.service_account_terraform["service_account"]
}

module "member_roles_terraform" {
  source                  = "../../../modules/iam/member-iam"
  service_account_address = data.google_service_account.terraform.email
  project                 = var.project_id
  project_roles           = ["roles/compute.admin", "roles/storage.admin", "roles/vpcaccess.admin", "roles/iam.serviceAccountAdmin", "roles/serviceusage.serviceUsageAdmin", "roles/dns.admin",]
}
