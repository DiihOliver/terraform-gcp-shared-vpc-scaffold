/******************************************
  Module for Private Access
 *****************************************/

module "private-service-access" {
  source   = "../../../../modules/networking/private_service_access"
  for_each = var.psa_config

  # --- Original variables ---
  psa_name      = each.value.psa_name
  project_id    = each.value.project_id
  vpc_network   = each.value.vpc_network
  address       = each.value.vpc_address
  prefix_length = each.value.prefix_length
  create_connection = each.value.create_connection
  # This expression builds the complete list of all psa_names that belong
  # to the same VPC as the current item in the loop.
  all_peering_range_names = [
    for config in var.psa_config : config.psa_name if config.vpc_network == each.value.vpc_network
  ]
}