
module "cr_negs" {
  source   = "../../../../modules/networking/terraform-google-serverless-neg"
  for_each = var.serverless_negs

  project                 = var.service_project_id
  region                  = var.region
  neg-name                    = "${var.neg-name}"
  cloud_run_service_names = each.value.cloud_run_services
}
