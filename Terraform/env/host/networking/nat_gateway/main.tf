/******************************************
  Module for NAT Gateway
 *****************************************/

module "cloud-nat" {
  source                             = "../../../../modules/networking/nat_gateway"
  for_each                           = var.nat_gateway
  project_id                         = each.value.project_id
  region                             = each.value.region
  router                             = each.value.router_name
  name                               = each.value.nat_name
  network                            = each.value.vpc_name
  address_name                       = each.value.address_name
  min_ports_per_vm                   = each.value.min_ports_per_vm
  icmp_idle_timeout_sec              = each.value.icmp_idle_timeout_sec
  tcp_established_idle_timeout_sec   = each.value.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec    = each.value.tcp_transitory_idle_timeout_sec
  udp_idle_timeout_sec               = each.value.udp_idle_timeout_sec
}
