# Static Global IPaddress Module

This module makes it easy to create Static Global IPaddress for the GCP Network.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | <4.0,>= 2.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | <4.0,>= 2.12 |

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.external_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address"></a> [address](#input\_address) | EXTERNAL indicates public/external single IP address. INTERNAL indicates internal IP ranges belonging to some network. | `string` | `" "` | no |
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | EXTERNAL indicates public/external single IP address. INTERNAL indicates internal IP ranges belonging to some network. | `string` | `"EXTERNAL"` | no |
| <a name="input_description"></a> [description](#input\_description) | The Region in which the created address should reside. | `string` | `""` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | The IP Version that will be used by this address | `string` | `"IPV4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the internal-ip. the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The URL of the network in which to reserve the IP range.This should only be set when using an Internal address. | `string` | `""` | no |
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | The prefix length of the IP range.This field is not applicable to addresses with addressType=EXTERNAL. | `string` | `0` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource deployed too. | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The purpose of the resource. For global internal addresses it can be VPC\_PEERING | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The created address of resource |
| <a name="output_id"></a> [id](#output\_id) | The created id of resource |
| <a name="output_project"></a> [project](#output\_project) | Project ID of external IP |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure