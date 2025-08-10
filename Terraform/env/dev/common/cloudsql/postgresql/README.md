# Google Cloud SQL PostgreSQL Module

This module  makes it easy to create Google CloudSQL instance and implement high availability settings.

Features : 
- Multi-Regional/Regional Cluster
- Backup configuration
- Add additional users


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
| <a name="module_cloud_dns"></a> [postgresql](#module\_cloud_dns_) | ../../../../../modules/cloudsql/postgresql | n/a |

## Enable APIs
In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

Cloud SQL Admin API - [ sqladmin.googleapis.com](https:// sqladmin.googleapis.com)

## Configure a Service Account

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/cloudsql.admin](https://cloud.google.com/iam/docs/understanding-roles)
- [roles/compute.networkAdmin](https://cloud.google.com/iam/docs/understanding-roles)

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud SQL API - sqladmin.googleapis.com

## Usage

Basic usage of this module is as follows:

* Google Cloud SQL PosegreSQL Module

```hcl
module "postgresql_instance" {
  source                          = "../../../../../modules/cloudsql/postgresql"
  project_id                      = var.service_project_id
  for_each                        = var.enable_postgresql_instance ? var.postgresql_instance : {}
  name                            = each.value.instance_name
  user_name                       = each.value.user_name
  deletion_protection             = each.value.deletion_protection
  enable_default_db               = each.value.enable_default_db
  enable_default_user             = each.value.enable_default_user
  database_version                = each.value.database_version
  region                          = each.value.region
  zone                            = each.value.zone
  tier                            = each.value.tier
  availability_type               = each.value.availability_type
  disk_size                       = each.value.disk_size
  disk_type                       = each.value.disk_type
  disk_autoresize                 = each.value.disk_autoresize
  maintenance_window_day          = each.value.maintenance_window_day
  maintenance_window_hour         = each.value.maintenance_window_hour
  maintenance_window_update_track = each.value.maintenance_window_update_track
  user_labels                     = each.value.user_labels
  create_timeout                  = var.create_timeout
  ip_configuration = {
    ipv4_enabled        = each.value.assign_public_ip
    require_ssl         = each.value.require_ssl
    private_network     = data.google_compute_network.my-network.self_link
    allocated_ip_range  = each.value.allocated_ip_range_name
    associated_networks = []
  }

  backup_configuration = {
    enabled                        = each.value.backup_enable
    binary_log_enabled             = each.value.binary_log_enabled
    start_time                     = each.value.start_time
    location                       = each.value.location
    transaction_log_retention_days = each.value.transaction_log_retention_days
    retained_backups               = each.value.retained_backups
    retention_unit                 = each.value.retention_unit
    point_in_time_recovery_enabled = each.value.point_in_time_recovery_enabled
  }
}
```

## Usage of tfvars file

Basic usage of this module is as follows:

* Google Cloud SQL PosegreSQL sample tfvars example

```hcl
project_id              = "project_id name"
vpc_network             = "vpc_network name"
region                  = "region name"
instance_name           = "PosegreSQL instance_name"
instance_type           = "PosegreSQL instance_type"
instance_primary_zone   = "XX"
availability_type       = "XXX"
# To make it easier to test this example, we are disabling deletion protection so we can destroy the databases
# during the tests. By default, we recommend setting deletion_protection to true, to ensure database instances are
# not inadvertently destroyed.
deletion_protection     = "true"
database_version        = "XXX"
disk_size = "XXX"
disk_type = "XXX"

database_flags = []
authorized_networks = []

maintenance_window_day ="XX"
maintenance_window_hour="XX"
transaction_log_retention_days="XX"

user_labels = {
  env = "XX"
  region = "XX"
  createdby = "terraform"
}

additional_users = []
private_network = "projects/project-id/global/networks/vpc-name"
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_users"></a> [additional\_users](#input\_additional\_users) | The users apart from root of the cloudsql PosegreSQL instance. | `any` | n/a | yes |
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | List of public IP ranges allowed to access SQL | `list(map(string))` | `[]` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | The availability\_type of the cloudsql PosegreSQL instance. REGIONAL or ZONAL | `string` | n/a | yes |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | The database\_flags of the cloudsql PosegreSQL instance. | `list` | n/a | yes |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | PostgreSQL Server version to use. | `string` | `"POSTGRES_16"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance. | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size for the master instance | `number` | `10` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | The disk type for the master instance. | `string` | `"PD_SSD"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the cloudsql PosegreSQL instance | `string` | n/a | yes |
| <a name="input_instance_primary_zone"></a> [instance\_primary\_zone](#input\_instance\_primary\_zone) | The primary zone of the cloudsql PosegreSQL instance. (a,b,c) | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the cloudsql PosegreSQL instance | `string` | n/a | yes |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | Maintenance Window Day | `number` | `"7"` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | Maintenace Window hour | `number` | `"12"` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | The resource link for the VPC network from which the Cloud SQL instance is accessible for private IP. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project to setup cloudsql PosegreSQL on | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to setup cloudsql PosegreSQL in | `string` | n/a | yes |
| <a name="input_transaction_log_retention_days"></a> [transaction\_log\_retention\_days](#input\_transaction\_log\_retention\_days) | Maximum days of logs to retain | `number` | `"7"` | no |
| <a name="input_user_labels"></a> [user\_labels](#input\_user\_labels) | The user\_labels of the cloudsql PosegreSQL instance. | `map` | n/a | yes |
| <a name="input_vpc_network"></a> [vpc\_network](#input\_vpc\_network) | Name of the VPC network to peer. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip_address"></a> [instance\_ip\_address](#output\_instance\_ip\_address) | The IPv4 address assigned for the master instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The instance name for the master instance |
| <a name="output_instance_self_link"></a> [instance\_self\_link](#output\_instance\_self\_link) | The URI of the master instance |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure
