# Google Compute Engine Module

This module makes it easy to create a Google Compute Engine (Virtual Machines)

- Google Compute Instance

Features:

- VM deletion protection
- Custom Service Accounts
- GCE custom machines

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.3 |
| google | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_dns"></a> [compute_instance](#module\_cloud_dns_) | ../../../../modules/compute-engine/linux-vm/ |

## Permissions

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/compute.instanceAdmin.v1](https://cloud.google.com/compute/docs/access/iam)
- [roles/iam.serviceAccountUser](https://cloud.google.com/compute/docs/access/iam)

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API: compute.googleapis.com


## Usage

Basic usage of this module is as follows:


* Google Compute Engine

```hcl
module "compute_instance" {
  source                  = "../../../../modules/compute-engine/linux-vm/"
  for_each                = var.compute_instance
  project                 = each.value.project_id
  region                  = each.value.region
  instance_count          = each.value.instance_count
  machine_name            = each.value.machine_name
  vm_description          = each.value.vm_description
  enable_external_ip      = each.value.enable_external_ip
  generate_internal_ip    = each.value.generate_internal_ip
  internal_ip_address     = each.value.internal_ip_address
  machine_type            = each.value.machine_type
  zone                    = each.value.machine_zone
  instance_labels         = each.value.instance_labels
  vm_deletion_protect     = each.value.vm_deletion_protect
  instance_image_selflink = each.value.instance_image_selflink
  network                 = each.value.network
  subnetwork              = each.value.subnetwork
  network_tags            = each.value.network_tags
  boot_disk_info          = each.value.boot_disk0_info
  service_account = each.value.service_account
}

```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
compute_instance = {
  compute_instance_01 = {
    machine_name            = "<machine_name>"
    project_id              = "<Project_ID>"
    machine_type            = "<machine_type>"
    region                  = "<region>"
    enable_external_ip      = false
    generate_internal_ip    = true
    internal_ip_address     = null
    network                 = "<vpc_name>"
    subnetwork              = "<subnet_name>"
    network_tags            = ["<network_tags>"]
    instance_count          = 1
    vm_description          = "vm_description"
    machine_zone            = "<zone>"
    vm_deletion_protect     = true
    instance_image_selflink = "<instance_image_selflink>"
    service_account = {
      email  = "<service_account_email>"
      scopes = ["<scope>"]
    }
    instance_labels = {
      "purpose" = "<purpose>",
      "env"     = "preprod"
    }
    boot_disk0_info = {
      disk_size_gb = 50
      disk_type    = "<disk_type>"
    }
  }
}

```

* Then perform the following commands in the directory:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | GCP Project ID where the GCE will be created | string | - | yes |
| region | The Region to deploy GCE | `string` | n/a | yes |
| machine_name | Name of the GCE Instance | string | - | yes |
| labels | A set of key/value label pairs to assign to the GCE | map | "" | no |
| machine_type | Type of the GCE Instance | string | - | yes |
| machine_zone | Specific Zone to deploy GCE | string | - | yes |
| instance_image_selflink | Selecting OS image | string | - | yes |
| network | Selecting VPC where the GCE will be created | string | - | yes |
| subnetwork | Selecting Subnet for GCE deployment | string | - | yes |
| network_tags | Attaching FW tags to GCE | string | - | no |
| internal_ip | Assigning Static IP for GCE | string | - | no |
| service_account | Service Account to be attached with GCE | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| Instance_name_vm01 | GCE VM Name | 
