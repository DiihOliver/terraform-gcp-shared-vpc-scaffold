# Google Cloud VPC Firewall Rules

This module makes it easy to create Firewall Rules for the GCP Network.

- Firewall Rules

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.new-firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Name of the resource. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource. | `any` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The name or self\_link of the network to attach this firewall to. | `any` | n/a | yes |
| <a name="input_ports"></a> [ports](#input\_ports) | An optional list of ports to which this rule applies. | `any` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The IP protocol to which this rule applies. | `any` | n/a | yes |
| <a name="input_source_ranges"></a> [source\_ranges](#input\_source\_ranges) | A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]. | `any` | n/a | yes |
| <a name="input_source_tags"></a> [source\_tags](#input\_source\_tags) | If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags. | `any` | n/a | yes |
| <a name="input_target_tags"></a> [target\_tags](#input\_target\_tags) | A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fw_id"></a> [fw\_id](#output\_fw\_id) | The URI of the created resource |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure