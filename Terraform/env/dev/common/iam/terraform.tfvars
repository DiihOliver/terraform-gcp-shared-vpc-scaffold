project_id = "<service-project-id>"

service_account_gke = {
  service_account = "dev-gke-sa"
}

service_account_mgmt = {
  service_account = "dev-mgmt-sa"
}

service_account_cr = {
  service_account = "dev-cr-sa"
}

service_account_cf = {
  service_account = "dev-cf-sa"
}

service_account_postgre = {
  service_account = "dev-postgre-sa"
}

service_account_terraform = {
  service_account = "dev-terraform-sa@<service-project-id>.iam.gserviceaccount.com"
}

/**********************************************************
  Newer structure for using Service Account Configurations
 **********************************************************/
service_account_configs = {
  sample-sa = {
    service_account_name    = "sample-sa"
    custom_role_id          = "sample_sa_role"
    custom_role_permissions = ["storage.objects.get", "storage.objects.list"]
    project_level_roles     = ["projects/<service-project-id>/roles/sample_sa_role"]
  }
}