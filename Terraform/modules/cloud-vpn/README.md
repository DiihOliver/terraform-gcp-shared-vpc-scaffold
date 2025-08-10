# GCP VPN Module
This module makes it easy for you to create an VPN using terraform

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Usage

Basic usage of this module is as follows:

- HA VPN GCP to AWS
```hcl
locals {
  router = (
    var.router_name == ""
    ? google_compute_router.router[0].name
    : var.router_name
  )
  peer_external_gateway = (
    var.peer_external_gateway != null
    ? google_compute_external_vpn_gateway.external_gateway[0].self_link
    : null

  )
  secret = random_id.secret.b64_url
}

resource "google_compute_ha_vpn_gateway" "ha_gateway" {
  provider = google-beta
  name     = var.name
  project  = var.project_id
  region   = var.region
  network  = var.network
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
  provider        = google-beta
  count           = var.peer_external_gateway != null ? 1 : 0
  name            = "external-${var.name}"
  project         = var.project_id
  redundancy_type = var.peer_external_gateway.redundancy_type
  description     = "Terraform managed external VPN gateway"
  dynamic "interface" {
    for_each = var.peer_external_gateway.interfaces
    content {
      id         = interface.value.id
      ip_address = interface.value.ip_address
    }
  }
}

resource "google_compute_router" "router" {
  provider = google-beta
  count    = var.router_name == "" ? 1 : 0
  name     = "vpn-${var.name}"
  project  = var.project_id
  region   = var.region
  network  = var.network
  bgp {
    advertise_mode = (
      var.router_advertise_config == null
      ? null
      : var.router_advertise_config.mode
    )
    advertised_groups = (
      var.router_advertise_config == null ? null : (
        var.router_advertise_config.mode != "CUSTOM"
        ? null
        : var.router_advertise_config.groups
      )
    )
    dynamic advertised_ip_ranges {
      for_each = (
        var.router_advertise_config == null ? {} : (
          var.router_advertise_config.mode != "CUSTOM"
          ? null
          : var.router_advertise_config.ip_ranges
        )
      )
      iterator = range
      content {
        range       = range.key
        description = range.value
      }
    }
    asn = var.router_asn
  }
}

resource "google_compute_router_peer" "bgp_peer" {
  for_each        = var.tunnels
  region          = var.region
  project         = var.project_id
  name            = "${var.name}-${each.key}"
  router          = local.router
  peer_ip_address = each.value.bgp_peer.address
  peer_asn        = each.value.bgp_peer.asn
  advertised_route_priority = (
    each.value.bgp_peer_options == null ? var.route_priority : (
      each.value.bgp_peer_options.route_priority == null
      ? var.route_priority
      : each.value.bgp_peer_options.route_priority
    )
  )
  advertise_mode = (
    each.value.bgp_peer_options == null ? null : each.value.bgp_peer_options.advertise_mode
  )
  advertised_groups = (
    each.value.bgp_peer_options == null ? null : (
      each.value.bgp_peer_options.advertise_mode != "CUSTOM"
      ? null
      : each.value.bgp_peer_options.advertise_groups
    )
  )
  dynamic advertised_ip_ranges {
    for_each = (
      each.value.bgp_peer_options == null ? {} : (
        each.value.bgp_peer_options.advertise_mode != "CUSTOM"
        ? {}
        : each.value.bgp_peer_options.advertise_ip_ranges
      )
    )
    iterator = range
    content {
      range       = range.key
      description = range.value
    }
  }
  interface = google_compute_router_interface.router_interface[each.key].name
}

resource "google_compute_router_interface" "router_interface" {
  provider   = google-beta
  for_each   = var.tunnels
  project    = var.project_id
  region     = var.region
  name       = "${var.name}-${each.key}"
  router     = local.router
  ip_range   = each.value.bgp_session_range == "" ? null : each.value.bgp_session_range
  vpn_tunnel = google_compute_vpn_tunnel.tunnels[each.key].name
}

resource "google_compute_vpn_tunnel" "tunnels" {
  provider                        = google-beta
  for_each                        = var.tunnels
  project                         = var.project_id
  region                          = var.region
  name                            = "${var.name}-${each.key}"
  router                          = local.router
  peer_external_gateway           = local.peer_external_gateway
  peer_external_gateway_interface = each.value.peer_external_gateway_interface
  peer_gcp_gateway                = var.peer_gcp_gateway
  vpn_gateway_interface           = each.value.vpn_gateway_interface
  ike_version                     = each.value.ike_version
  shared_secret                   = each.value.shared_secret == "" ? local.secret : each.value.shared_secret
  vpn_gateway                     = google_compute_ha_vpn_gateway.ha_gateway.self_link
}

resource "random_id" "secret" {
  byte_length = 8
}
```
## Resources

- google-beta_google_compute_external_vpn_gateway.external_gateway
- google-beta_google_compute_ha_vpn_gateway.ha_gateway
- google-beta_google_compute_router.router
- google-beta_google_compute_router_interface.router_interface
- google-beta_google_compute_vpn_tunnel.tunnels
- google_compute_router_peer.bgp_peer
- random_id.secret

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | VPN gateway name, and prefix used for dependent resources. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | VPC used for the gateway and routes. | `string` | n/a | yes |
| <a name="input_peer_external_gateway"></a> [peer\_external\_gateway](#input\_peer\_external\_gateway) | Configuration of an external VPN gateway to which this VPN is connected. | <pre>object({<br>    redundancy_type = string<br>    interfaces = list(object({<br>      id         = number<br>      ip_address = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_peer_gcp_gateway"></a> [peer\_gcp\_gateway](#input\_peer\_gcp\_gateway) | Self Link URL of the peer side HA GCP VPN gateway to which this VPN tunnel is connected. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project where resources will be created. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region used for resources. | `string` | n/a | yes |
| <a name="input_route_priority"></a> [route\_priority](#input\_route\_priority) | Route priority, defaults to 1000. | `number` | `1000` | no |
| <a name="input_router_advertise_config"></a> [router\_advertise\_config](#input\_router\_advertise\_config) | Router custom advertisement configuration, ip\_ranges is a map of address ranges and descriptions. | <pre>object({<br>    groups    = list(string)<br>    ip_ranges = map(string)<br>    mode      = string<br>  })</pre> | `null` | no |
| <a name="input_router_asn"></a> [router\_asn](#input\_router\_asn) | Router ASN used for auto-created router. | `number` | `64514` | no |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | Name of router, leave blank to create one. | `string` | `""` | no |
| <a name="input_tunnels"></a> [tunnels](#input\_tunnels) | VPN tunnel configurations, bgp\_peer\_options is usually null. | <pre>map(object({<br>    bgp_peer = object({<br>      address = string<br>      asn     = number<br>    })<br>    bgp_peer_options = object({<br>      advertise_groups    = list(string)<br>      advertise_ip_ranges = map(string)<br>      advertise_mode      = string<br>      route_priority      = number<br>    })<br>    bgp_session_range               = string<br>    ike_version                     = number<br>    vpn_gateway_interface           = number<br>    peer_external_gateway_interface = number<br>    shared_secret                   = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_gateway"></a> [external\_gateway](#output\_external\_gateway) | External VPN gateway resource. |
| <a name="output_gateway"></a> [gateway](#output\_gateway) | HA VPN gateway resource. |
| <a name="output_name"></a> [name](#output\_name) | VPN gateway name. |
| <a name="output_random_secret"></a> [random\_secret](#output\_random\_secret) | Generated secret. |
| <a name="output_router"></a> [router](#output\_router) | Router resource (only if auto-created). |
| <a name="output_router_name"></a> [router\_name](#output\_router\_name) | Router name. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | HA VPN gateway self link. |
| <a name="output_tunnel_names"></a> [tunnel\_names](#output\_tunnel\_names) | VPN tunnel names. |
| <a name="output_tunnel_self_links"></a> [tunnel\_self\_links](#output\_tunnel\_self\_links) | VPN tunnel self links. |
| <a name="output_tunnels"></a> [tunnels](#output\_tunnels) | VPN tunnel resources. |


* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure

## The Terraform resources will consists of following structure
```
├── README.md                 // Description of the module and what it should be used for.
├── main.tf                   // The primary entrypoint for terraform resources.
├── variables.tf              // It contain the declarations for variables.
├── outputs.tf                // It contain the declarations for outputs.
├── versions.tf               // To specify terraform versions.
```