output "vpn_name" {
  value     = module.vpn_ha // Returns the VPN module's high availability configuration.
  sensitive = true          // The output value is sensitive and should be handled carefully.
}
