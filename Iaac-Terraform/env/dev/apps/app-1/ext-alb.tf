# /**
#  * =================================================================
#  * ROOT TERRAFORM CONFIGURATION
#  *
#  * The module handles the creation of all other load balancer 
#  * components for the Shared VPC setup.
#  * =================================================================
#  */


module "shared_vpc_lb" {
  source = "../../../../modules/networking/loadbalancer/external_https_lb"
  host_project_id    = var.host_project_id
  service_project_id = var.service_project_id
  prefix             = var.prefix
  name               = var.name
  backend_config     = var.backend_config
  certificate_map_name = var.certificate_map_name
  routing_rules = var.routing_rules
  enable_http_to_https_redirect = false
  enable_cdn = false
  depends_on = [module.cr_negs]
}
