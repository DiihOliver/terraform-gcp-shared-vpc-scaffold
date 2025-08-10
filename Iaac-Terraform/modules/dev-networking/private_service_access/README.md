# Private Service Connection Module

This module makes it easy to create Private Service Connection for the GCP Network.

- Private Access

*Note*: Private services access is a private connection between your VPC network and a network owned by Google or a third party

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.google-managed-services-range](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_service_networking_connection.private_service_access](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_networking_connection) | resource |
| [null_resource.dependency_setter](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address"></a> [address](#input\_address) | First IP address of the IP range to allocate to CLoud SQL instances and other Private Service Access services. If not set, GCP will pick a valid one for you. | `string` | `""` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | IP Version for the allocation. Can be IPV4 or IPV6. | `string` | `""` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The key/value labels for the IP range allocated to the peered network. | `map(string)` | `{}` | no |
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | Prefix length of the IP range reserved for Cloud SQL instances and other Private Service Access services. Defaults to /16. | `number` | `16` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID of the VPC network to peer. This can be a shared VPC host projec. | `string` | n/a | yes |
| <a name="input_vpc_network"></a> [vpc\_network](#input\_vpc\_network) | Name of the VPC network to peer. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | First IP of the reserved range. |
| <a name="output_google_compute_global_address_name"></a> [google\_compute\_global\_address\_name](#output\_google\_compute\_global\_address\_name) | URL of the reserved range. |
| <a name="output_peering_completed"></a> [peering\_completed](#output\_peering\_completed) | Use for enforce ordering between resource creation |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure