# Custom Cloud Memorystore Module

This module allows us to create a basic Cloud Memorystore Redis instance.

## Compatibility

This module is meant for use with Terraform v1.5.3.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.3 |

## Usage

Basic usage of this module is as follows:


```hcl
module "memorystore" {

  source   = "../../modules/memorystore/"
  project  = var.service_project_id
  for_each = var.enable_memorystore_creation ? var.memorystore : {}
  name     = each.value.app_name
  // Configuration 
  tier               = each.value.tier
  replica_count      = each.value.replica_count
  read_replicas_mode = each.value.read_replicas_mode
  memory_size_gb     = each.value.memory_size_gb
  connect_mode       = each.value.connect_mode
  redis_version      = each.value.redis_version
  labels             = each.value.labels
  maintenance_policy = each.value.maintenance_policy

  // Networking
  region                  = each.value.region
  location_id             = each.value.location_id
  alternative_location_id = each.value.alternative_location_id
  authorized_network      = var.vpc_name

}
```
## Terraform files
* * *
- Inside each subfolder the terraform files are present and these files are responsible for creating resources in GCP projects.
- Details of each file is given in the table below
​

| FILE NAME | DESCRIPTION | 
|----------- | --------------------------------------------------------------------------------------------|
|backend.tf | To specify remote backend of GCS to store tfstate files|
|main.tf | This file defines modules for the resource provisioning |
|output.tf | This file defines the outputs of different resources provisioned by terraform |
|provider.tf | This file specifies the google provider to be used by the terraform module |
|variables.tf | This file contains the declaration of variables for different resources |
|versions.tf | This file defines the version constraints for various modules and plugins used in terraform configuration |
|mum.tfvars | This file stores the input variables values that are used for provisioning resources in mMmbai region |
|del.tfvars | This file stores the input variables values that are used for provisioning resources in Delhi region |
|cloudbuild-plan.yaml | This file contains the information regarding cloudbuild trigger to plan the provisioning of resource |
|cloudbuild-apply.yaml | This file contains the information regarding cloudbuild trigger to apply the provisioning of resource |

## Backend information
***
- We are using remote backend to save terraform state file. The tf state file is stored in GCS bucket hosted in project
- The GCS bucket name is bucketname.

## Relevance of multiple tfvars (Select the region for GCP resources)
* * *
​
Update input variables in below files based on the region.
```diff
+ We are using two different tfvars file based on the region we want to deploy resources. There are two files mum (Mumbai) and del(delhi)
```
​
| File | Environment | 
|------|-------------|
| mum.tfvars | To create GCP resources in Mumbai region |
| del.tfvars | To create GCP resources in Delhi region |

## Inputs Variables

| Name                              | Description | Type |
|-----------------------------------|-------------|------|
| project                           | The Project ID in which the Redis Instance will provision | `string` |
| region                            | Region in which the Redis Instance will provision | `string` |
| name                              | Name of the Cloud Memorystore Redis Instance | `string` |
| tier                              | Tier of the Redis Instance. BASIC or STANDARD_HA | `string` |
| memory\_size\_gb                  | Size of the memory allocated to the instance. | `number` |
| location\_id                      | The zone where the instance will be provisioned. | `string` |
| alternative\_location\_id         | Only applicable to STANDARD_HA tier which protects the instance against zonal failures by provisioning it across two zones. If provided, it must be a different zone from the one provided in [location_id]. | `string` |
| authorized\_network               | The full name of the Google Compute Engine network to which the instance is connected. | `string` |
| connect\_mode                     | The connection mode of the Redis instance. Default value is DIRECT_PEERING. Possible values are DIRECT_PEERING and PRIVATE_SERVICE_ACCESS | `string` |
| redis\_version                    | The version of Redis software.  | `string` |
| display\_name                     | An arbitrary and optional user-provided name for the instance | `string` |
| auth\_enabled                     | Indicates whether OSS Redis AUTH is enabled for the instance. | `bool` |
| transit\_encryption\_mode         | The TLS mode of the Redis instance, If not provided, TLS is disabled for the instance. Default value is DISABLED. Possible values are SERVER_AUTHENTICATION and DISABLED. | `string` |
| replica\_count                    | The number of replica nodes. The valid range for the Standard Tier with read replicas enabled is [1-5] and defaults to 2. If read replicas are not enabled for a Standard Tier instance, the only valid value is 1 and the default is 1. The valid value for basic tier is 0 and the default is also 0. | string |
| labels                            | Service account to be attached to the vm. | `number` |
| day                               | The day of week that maintenance updates occur.Possible values are DAY_OF_WEEK_UNSPECIFIED, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, and SUNDAY. | `string` |
| start\_time                       | Start time of the window in UTC time. Need to provide hours, minutes, seconds and nanos | `number` |


### Software

The following dependencies must be available:

- [Terraform][terraform] v1.5.3
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- Compute Admin: `roles/redis.admin`


### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- `redis.googleapis.com`


## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html


