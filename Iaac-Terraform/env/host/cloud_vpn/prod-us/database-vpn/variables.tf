variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  description = "Default Region"
}

variable "vpn_ha" {
  description = "The list of the service projets backend bucket names."
  type = map(object({
    project_id = string
    region     = string
    vpc_name   = string
    router_asn = number
    /* To create the IP address of the Cloud VPN Gateway, comment on the lines below and execute the Terraform code.
  Next, after obtaining VPN configuration data from AWS, fill the fields, remove the comments from the lines below, and execute the Terraform code once again. */
    peer_external_gateway = object({
      redundancy_type = string
      interfaces = list(object({
        id         = number
        ip_address = string
      }))
    })
    tunnels = map(object({
      bgp_peer = object({
        address = string
        asn     = number
      })
      bgp_peer_options = object({
        advertise_groups    = list(string)
        advertise_ip_ranges = map(string)
        advertise_mode      = string
        route_priority      = optional(number)
      })
      bgp_session_range               = string
      ike_version                     = number
      vpn_gateway_interface           = number
      peer_external_gateway_interface = number
      shared_secret                   = string
    }))
  }))
  default = {}
}
