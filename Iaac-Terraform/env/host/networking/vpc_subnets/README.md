# Google Cloud Shared VPC
This module allows creation of an Custom Shared VPC and Subnets network.
It also provides the use of secondary rnages for GKE


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) |  >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.85.0 |

## Permissions

In order to execute this module you must have a Service Account with the
following project roles:

On Organization level:
- Compute Shared VPC Admin [roles/compute.xpnAdmin] (https://cloud.google.com/iam/docs/understanding-roles#compute.xpnAdmin)

On Project Level:
- Compute Admin [roles/compute.admin](https://cloud.google.com/nat/docs/using-nat#iam_permissions) on the project.
- Compute Network Admin [roles/compute.networkAdmin](https://cloud.google.com/nat/docs/using-nat#iam_permissions) on the project.

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - `compute.googleapis.com`

## Usage
Basic usage of the module is as follows:
- Creating VPC
```hcl
module "svc_project_networking" {
  for_each                           = var.svc_project_networking
  source                             = "../../../../../module/shared-vpc"
  network_name                       = each.value.network_name
  project_id                         = var.host_project_id
  routing_mode                       = each.value.routing_mode
  subnets                            = each.value.subnets
  secondary_ranges                   = each.value.secondary_ranges
}
```
- Enable A Shared VPC in the host project
``hcl
resource "google_compute_shared_vpc_host_project" "host" {
  project    = var.host_project_id
  depends_on = [module.svc_project_networking]
}
```
- To attach both dev and prod(service project) with host project 
``hcl
resource "google_compute_shared_vpc_service_project" "service_project" {
  count           = length(var.service_project_ids)
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = var.service_project_ids[count.index]
  depends_on      = [resource.google_compute_shared_vpc_host_project.host]
}
```

- Provide the variables values to the modules from terraform.tfvars file.

```hcl
vpc_subnets = {
  vpc_subnets = {
    network_name                     = "NETWORK_NAME"
    routing_mode                     = "GLOBAL"
    subnets = [
      {
        subnet_name           = "SUBNET_NAME"
        subnet_cidr           = "IP_RANGES"
        subnet_region         = "REGION"
        purpose               = null
        subnet_private_access = "BOOL"
        subnet_flow_logs      = "BOOL"
      }
    ]
    secondary_ranges = {
      Subnet_name = [
        {
          range_name    = "Range_name"
          ip_cidr_range = "IP_RANGES"
        },
        {
          range_name    = "Range_name"
          ip_cidr_range = "IP_RANGES"
        }
      ]
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_project_id"></a> [host\_project\_id](#input\_host\_project\_id) | Host Project ID. | `string` | n/a | yes |
| <a name="input_service_project_ids"></a> [service\_project\_ids](#input\_service\_project\_ids) | List of Service Project IDs | `list(string)` | n/a | yes |
| <a name="input_svc_project_networking"></a> [svc\_project\_networking](#input\_svc\_project\_networking) | The GKE cluster name, node pool  and metadata list for the Service project's GKE. | <pre>map(object({<br>    network_name                     = string<br>    routing_mode                     = string<br>    subnets                          = list(map(string))<br>    secondary_ranges                 = map(list(object({ range_name = string, ip_cidr_range = string })))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_global_vpc"></a> [global\_vpc](#output\_global\_vpc) | n/a |

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
├── terraform.tfvars          // The file to pass the terraform variables values.
├──providers.tf               // To specify infrastructure vendors.
├── backend.tf                // To create terraform backend state configuration.
