# Private Service Connection Module

This module makes it easy to create Private Service Connection for the GCP Network.

- Private Access

*Note*: Private services access is a private connection between your VPC network and a network owned by Google or a third party

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_dns"></a> [private-services-access](#module\_cloud_dns_) | ../../../../modules/networking/private_service_access | n/a |


## Permissions

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/compute.networkAdmin](https://cloud.google.com/iam/docs/understanding-roles)

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

## Usage
Basic usage of this module is as follows:

* Private Access

```hcl
module "private-service-access" {
  source        = "../../../../modules/networking/private_service_access"
  psa_name = var.psa_name
  project_id    = var.service_project_id
  vpc_network   = var.vpc_network
  address       = var.vpc_address
  prefix_length = var.prefix_length
}
```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
project_id = "project_id"
vpc_network = "vpc name"
region = "region name"
vpc_address = "XXXX" #please provide the internal IP which is NOT in range with the subnet CIDR
prefix_length = "XX" 
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | Prefix length of the IP range reserved for Cloud SQL and Redis instances and other Private Service Access services. Defaults to /16. | `number` | `16` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID of the VPC network to peer. This can be a shared VPC host projec. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region for the VPC network | `any` | n/a | yes |
| <a name="input_vpc_address"></a> [vpc\_address](#input\_vpc\_address) | First IP address of the IP range to allocate to Cloud SQL and Redis instances and other Private Service Access services. If not set, GCP will pick a valid one for you. | `string` | `""` | no |
| <a name="input_vpc_network"></a> [vpc\_network](#input\_vpc\_network) | The vpc ID of the VPC network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_reserved_range_address"></a> [reserved\_range\_address](#output\_reserved\_range\_address) | The Global Address resource name |
| <a name="output_reserved_range_name"></a> [reserved\_range\_name](#output\_reserved\_range\_name) | The Global Address resource name |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure