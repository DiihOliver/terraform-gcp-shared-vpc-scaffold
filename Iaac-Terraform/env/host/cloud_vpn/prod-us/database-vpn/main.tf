module "vpn_ha" {
  source     = "../../../../../modules/cloud-vpn"
  for_each   = var.vpn_ha
  name       = each.key
  project_id = each.value.project_id
  region     = each.value.region
  network    = each.value.vpc_name
  router_asn = each.value.router_asn
  /* To create the IP address of the Cloud VPN Gateway, comment on the lines below and execute the Terraform code.
  Next, after obtaining VPN configuration data from AWS, fill the fields, remove the comments from the lines below, and execute the Terraform code once again. */
  peer_external_gateway = each.value.peer_external_gateway
  tunnels               = each.value.tunnels
}
