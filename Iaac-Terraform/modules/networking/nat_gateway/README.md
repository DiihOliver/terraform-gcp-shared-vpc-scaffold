# Project NAT Gateway Module

This module makes it easy to create NAT Gateway for the GCP Network.

- Static External IP addresses
- Cloud Router
- NAT Gateway

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_router"></a> [create\_router](#input\_create\_router) | Create router instead of using an existing one, uses 'router' variable for new resource name. | `bool` | `false` | no |
| <a name="input_icmp_idle_timeout_sec"></a> [icmp\_idle\_timeout\_sec](#input\_icmp\_idle\_timeout\_sec) | Timeout (in seconds) for ICMP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |
| <a name="input_log_config_enable"></a> [log\_config\_enable](#input\_log\_config\_enable) | Indicates whether or not to export logs | `bool` | `false` | no |
| <a name="input_log_config_filter"></a> [log\_config\_filter](#input\_log\_config\_filter) | Specifies the desired filtering of logs on this NAT. Valid values are: "ERRORS\_ONLY", "TRANSLATIONS\_ONLY", "ALL" | `string` | `"ALL"` | no |
| <a name="input_min_ports_per_vm"></a> [min\_ports\_per\_vm](#input\_min\_ports\_per\_vm) | Minimum number of ports allocated to a VM from this NAT config. Defaults to 64 if not set. Changing this forces a new NAT to be created. | `string` | `"64"` | no |
| <a name="input_name"></a> [name](#input\_name) | Defaults to 'cloud-nat-RANDOM\_SUFFIX'. Changing this forces a new NAT to be created. | `string` | `""` | no |
| <a name="input_nat_ip_allocate_option"></a> [nat\_ip\_allocate\_option](#input\_nat\_ip\_allocate\_option) | Value inferred based on nat\_ips. If present set to MANUAL\_ONLY, otherwise AUTO\_ONLY. | `string` | `"false"` | no |
| <a name="input_nat_ips"></a> [nat\_ips](#input\_nat\_ips) | List of self\_links of external IPs. Changing this forces a new NAT to be created. | `list(string)` | `[]` | no |
| <a name="input_network"></a> [network](#input\_network) | VPN name, only if router is not passed in and is created by the module. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy to | `any` | n/a | yes |
| <a name="input_router"></a> [router](#input\_router) | The name of the router in which this NAT will be configured. Changing this forces a new NAT to be created. | `any` | n/a | yes |
| <a name="input_router_asn"></a> [router\_asn](#input\_router\_asn) | Router ASN, only if router is not passed in and is created by the module. | `string` | `"64514"` | no |
| <a name="input_source_subnetwork_ip_ranges_to_nat"></a> [source\_subnetwork\_ip\_ranges\_to\_nat](#input\_source\_subnetwork\_ip\_ranges\_to\_nat) | Defaults to ALL\_SUBNETWORKS\_ALL\_IP\_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL\_SUBNETWORKS\_ALL\_IP\_RANGES, ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES, LIST\_OF\_SUBNETWORKS. Changing this forces a new NAT to be created. | `string` | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | no |
| <a name="input_subnetworks"></a> [subnetworks](#input\_subnetworks) | n/a | <pre>list(object({<br>    name                     = string,<br>    source_ip_ranges_to_nat  = list(string)<br>    secondary_ip_range_names = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tcp_established_idle_timeout_sec"></a> [tcp\_established\_idle\_timeout\_sec](#input\_tcp\_established\_idle\_timeout\_sec) | Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set. Changing this forces a new NAT to be created. | `string` | `"1200"` | no |
| <a name="input_tcp_transitory_idle_timeout_sec"></a> [tcp\_transitory\_idle\_timeout\_sec](#input\_tcp\_transitory\_idle\_timeout\_sec) | Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |
| <a name="input_udp_idle_timeout_sec"></a> [udp\_idle\_timeout\_sec](#input\_udp\_idle\_timeout\_sec) | Timeout (in seconds) for UDP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Name of the Cloud NAT |
| <a name="output_nat_ip_allocate_option"></a> [nat\_ip\_allocate\_option](#output\_nat\_ip\_allocate\_option) | NAT IP allocation mode |
| <a name="output_region"></a> [region](#output\_region) | Cloud NAT region |
| <a name="output_router_name"></a> [router\_name](#output\_router\_name) | Cloud NAT router name |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure