# Project NAT Gateway Module

This module makes it easy to create NAT Gateway for the GCP Network.

- Static External IP addresses
- Cloud Router
- NAT Gateway

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_dns"></a> [cloud-nat](#module\_cloud_dns_) | ../../../../modules/networking/nat_gateway | n/a |


## Configure a Service Account

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/compute.networkAdmin](https://cloud.google.com/nat/docs/using-nat#iam_permissions)

## Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

## Usage
Basic usage of this module is as follows:

* Reserve Static External IP addresses

```hcl
resource "google_compute_address" "address" {
  count  = 1
  name   = var.address_name
  region = var.region
}
```

* Cloud Router

```hcl
resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region
  network = var.vpc_name
}
```

* Cloud NAT Gateway

```hcl
module "cloud-nat" {
  source                             = "../../../../modules/networking/nat_gateway"
  project_id                         = var.service_project_id
  region                             = var.region
  router                             = google_compute_router.router.name
  name                               = var.nat_name
  nat_ips                            = google_compute_address.address.*.self_link
  min_ports_per_vm                   = "128"
  icmp_idle_timeout_sec              = "15"
  tcp_established_idle_timeout_sec   = "600"
  tcp_transitory_idle_timeout_sec    = "15"
  udp_idle_timeout_sec               = "15"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
```

* Provide the variables values to the modules from terraform.tfvars file.

```hcl
project_id   = "project_id"
region       = "region name"
vpc_name     = "vpc_name"
nat_name = "nat_name"
router_name = "router_name"
address_name = "address_name"
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID to reserve static IPs | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to reserve static IPs | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the network for which NAT gateway will be created | `any` | n/a | yes |
| <a name="input_nat_name"></a> [nat_name](#input\_nat\_name) | The name of the NAT gateway which will be created | `any` | n/a | yes |
| <a name="input_router_name"></a> [router_name](#input\_router\_name) | The name of the router which will be created | `any` | n/a | yes |
| <a name="input_address_name"></a> [address_name](#input\_address\_name) | The name of the IP | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_nat_name"></a> [cloud\_nat\_name](#output\_cloud\_nat\_name) | Name of the Cloud NAT |

* Then perform the following commands in the directory:

   `terraform init` to get the plugins

   `terraform plan` to see the infrastructure plan

   `terraform apply` to apply the infrastructure build

   `terraform destroy` to destroy the built infrastructure