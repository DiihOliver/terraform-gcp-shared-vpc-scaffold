/******************************************
  Module for GKE
 *****************************************/
module "service_account_gke" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_gke["service_account"]
}
module "member_roles_gke" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_gke.email
  project                 = var.project_id
  project_roles           = ["roles/container.defaultNodeServiceAccount", "roles/artifactregistry.reader", "roles/container.developer", "roles/logging.logWriter", "roles/secretmanager.secretAccessor", "roles/iam.serviceAccountUser", "roles/iam.workloadIdentityUser"]
}

/******************************************
  Module for Management VM
 *****************************************/
module "service_account_mgmt" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_mgmt["service_account"]
}
module "member_roles_mgmt" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_mgmt.email
  project                 = var.project_id
  project_roles           = ["roles/compute.admin", "roles/iam.serviceAccountUser", "roles/artifactregistry.reader", "roles/container.developer", "roles/cloudsql.admin", "roles/redis.admin", "roles/datamigration.admin","roles/pubsub.viewer","roles/pubsub.publisher","roles/pubsub.subscriber"]
}

/******************************************
  Module for Cloud Run
 *****************************************/
module "service_account_cr" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_cr["service_account"]
}
module "member_roles_cr" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_cr.email
  project                 = var.project_id
  project_roles           = ["roles/logging.logWriter", "roles/secretmanager.secretAccessor", "roles/artifactregistry.reader", "roles/storage.objectViewer", "roles/pubsub.publisher", "roles/pubsub.subscriber", "roles/cloudsql.client", "roles/eventarc.eventReceiver"]
}

/******************************************
  Module for Cloud Run Function
 *****************************************/
module "service_account_cf" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_cf["service_account"]
}
module "member_roles_cf" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_cf.email
  project                 = var.project_id
  project_roles           = ["roles/logging.logWriter", "roles/secretmanager.secretAccessor", "roles/artifactregistry.reader", "roles/storage.objectViewer", "roles/pubsub.publisher", "roles/pubsub.subscriber", "roles/cloudsql.client", "roles/eventarc.eventReceiver"]
}

/******************************************
  Module for PostgreSQL VM
 *****************************************/
module "service_account_postgre" {
  source               = "../../../../modules/iam/service-account-new"
  project_id           = var.project_id
  service_account_name = var.service_account_postgre["service_account"]
}

module "member_roles_postgre" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = module.service_account_postgre.email
  project                 = var.project_id
  project_roles           = ["roles/compute.admin", "roles/iam.serviceAccountUser"]
}

/******************************************
  Module for Terraform Deployment
 *****************************************/
data "google_service_account" "terraform" {
  account_id = var.service_account_terraform["service_account"]
}

module "member_roles_terraform" {
  source                  = "../../../../modules/iam/member-iam"
  service_account_address = data.google_service_account.terraform.email
  project                 = var.project_id
  project_roles           = ["roles/redis.admin", "roles/compute.admin", "roles/storage.admin", "roles/iam.serviceAccountUser", "roles/container.admin", "roles/artifactregistry.admin", "roles/vpcaccess.admin", "roles/iam.serviceAccountAdmin", "roles/serviceusage.serviceUsageAdmin", "roles/dns.admin", "roles/cloudsql.admin","roles/storagetransfer.admin", "roles/cloudscheduler.admin","roles/cloudfunctions.admin"]
}
