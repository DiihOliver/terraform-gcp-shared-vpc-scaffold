## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.16, <4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.16, <4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_region_network_endpoint_group.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_network_endpoint_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_run_service_names"></a> [cloud\_run\_service\_names](#input\_cloud\_run\_service\_names) | List of Cloud Run service names deployed in the project | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the network endpoint group | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy the network endpoint group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_neg_ids"></a> [neg\_ids](#output\_neg\_ids) | Map of network endpoint group IDs by Cloud Run service name |
