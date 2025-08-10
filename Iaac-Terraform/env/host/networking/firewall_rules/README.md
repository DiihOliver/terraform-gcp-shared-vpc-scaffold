# Google Cloud VPC Firewall Rules

This module makes it easy to create Firewall Rules for the GCP Network.

- Firewall Rules

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_dns"></a> [fw-rules](#module\_cloud_dns_) | ../../../../modules/networking/firewall | n/a |



- [roles/compute.networkAdmin](https://cloud.google.com/iam/docs/understanding-roles)

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

## Usage

Basic usage of this module is as follows:

* Module for Firewall Rules

```hcl
module "fw_rules" {
  source = "../../../../modules/networking/firewall"

  for_each = { for rule in var.firewall_rules : rule.name => rule }

  network       = var.vpc_name
  name          = each.value.name
  protocol      = each.value.protocol
  ports         = each.value.ports
  source_ranges = each.value.source_ranges
  source_tags   = each.value.source_tags
  target_tags   = each.value.target_tags
}
```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
project_id   = "project_id"
region       = "project-region"
vpc_name     = "vpc_name"
firewall_rules = [
  {
    network       = "vpc_name"
    name          = "name_of_the_firewall"
    protocol      = "protocol"
    ports         = ["port_no"]
    source_ranges = ["source_ranges"]
    source_tags   = ["tags"]
    target_tags   = ["target_tags"]
  },
]
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID to reserve static IPs | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to reserve static IPs | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the network for which Firewall rules will be created | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [firewall_rules](#input\_vpc\_name) | Configuration Firewall rules which will be created | <pre>list(object({ <br>network       = string <br>name          = string<br>protocol      = string<br> ports         = list(string)<br>source_ranges = list(string)<br>source_tags   = list(string)<br>target_tags   = list(string)
  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fw_rule"></a> [fw\_rule](#output\_fw\_rules) | Firewall Rule created for IAP SSH |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure
