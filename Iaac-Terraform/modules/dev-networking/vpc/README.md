# Project Network and Subnetwork Module

This module makes it easy to create Network for the GCP Network.

- Network (Virtual Private Cloud)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_shared_vpc_host_project.shared_vpc_host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_host_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `any` | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| <a name="input_shared_vpc_host"></a> [shared\_vpc\_host](#input\_shared\_vpc\_host) | Makes this project a Shared VPC host if 'true' (default 'false') | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | The VPC resource being created |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | The URI of the VPC being created |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | VPC project id |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure