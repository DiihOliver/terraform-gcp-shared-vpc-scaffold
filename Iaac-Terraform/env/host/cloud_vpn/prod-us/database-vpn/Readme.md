## Creating GCP VPN Resources with Terraform**

This guide outlines the steps to create the GCP side of VPN resources using Terraform. Please follow the steps below:

1. Start by commenting out the Tunnel configuration section in your Terraform code. This is typically done by adding the appropriate comment characters (`#` or `/* ... */`) to disable that section.

2. Apply the Terraform configuration to create the VPN gateway resource and router in GCP. Use the following command:
   ```
   terraform apply
   ```

   Review the execution plan and confirm the changes to provision the VPN gateway and router.

3. Once the GCP side resources are created, obtain the interface details from GCP. These details will be needed to create the AWS side of the VPN resources.

4. Proceed to create the AWS side of the VPN resources using the interface details obtained in the previous step. Configure the VPN in AWS with the necessary parameters and settings to establish the connection between GCP and AWS.

5. Download the VPN configuration files from AWS. These files contain the necessary tunnel and BGP details required for the GCP side configuration.

6. Uncomment the previously commented Tunnel configuration section in your Terraform code. Remove the comment characters (`#` or `/* ... */`) to enable that section.

7. Open the downloaded VPN configuration files from AWS and retrieve the tunnel and BGP details.

8. Update the Tunnel configuration section in your Terraform code with the details obtained from the AWS side VPN configuration files.

9. Reapply the Terraform code to apply the updated configuration:
   ```
   terraform apply
   ```

   Confirm the changes to configure the tunnels on the GCP side with the corresponding AWS VPN configuration details.

Please ensure you have the necessary prerequisites, such as a configured Terraform environment and access to both GCP and AWS accounts, before proceeding with these steps.

Remember to review and validate your configurations carefully to ensure a successful and secure VPN connection between GCP and AWS.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 3.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 3.15 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpn_ha"></a> [vpn\_ha](#module\_vpn\_ha) | ../../../../modules/networking/cloud-vpn | n/a |


## Usage

Basic usage of this module is as follows:

- HA VPN GCP to AWS
```hcl
module "vpn_ha" {
  source     = "../../../../modules/networking/cloud-vpn"
  for_each   = var.vpn_ha
  name       = each.key
  project_id = each.value.project_id
  region     = each.value.region
  network    = each.value.vpc_name
  router_asn = each.value.router_asn
  /* To create the IP address of the Cloud VPN Gateway, comment on the lines below and execute the Terraform code.
  Next, after obtaining VPN configuration data from AWS, fill the fields, remove the comments from the lines below, and execute the Terraform code once again. */
  peer_external_gateway = each.value.peer_external_gateway
  tunnels               = each.value.tunnels
}
```
- Provide the variables values to the modules from terraform.tfvars file.

```hcl
vpn_ha = {
  "networking-qa-us-central1-vpn" = {
    project_id = "PROJECT_ID"
    region     = "REGION"
    vpc_name   = "VPC_NAME"
    router_asn = 65000

    peer_external_gateway = {
      redundancy_type = "FOUR_IPS_REDUNDANCY"
      interfaces = [{
        id         = 0
        ip_address = ""
        },
        {
          id         = 1
          ip_address = ""
        },
        {
          id         = 2
          ip_address = ""
        },
        {
          id         = 3
          ip_address = ""
      }]
    }

    tunnels = {
      remote-0 = {
        bgp_peer = {
          address = ""
          asn     = 64512
        }
        bgp_peer_options                = null
        bgp_session_range               = "1"
        ike_version                     = 2
        vpn_gateway_interface           = 0
        peer_external_gateway_interface = 0
        shared_secret                   = "" #secret_key_phrase0
      }
      remote-1 = {
        bgp_peer = {
          address = ""
          asn     = 64512
        }
        bgp_peer_options                = null
        bgp_session_range               = ""
        ike_version                     = 2
        vpn_gateway_interface           = 0
        peer_external_gateway_interface = 1
        shared_secret                   = "" #secret_key_phrase1
      }
      remote-2 = {
        bgp_peer = {
          address = ""
          asn     = 64512
        }
        bgp_peer_options                = null
        bgp_session_range               = ""
        ike_version                     = 2
        vpn_gateway_interface           = 1
        peer_external_gateway_interface = 2
        shared_secret                   = "" #secret_key_phrase2
      }
      remote-3 = {
        bgp_peer = {
          address = ""
          asn     = 64512
        }
        bgp_peer_options                = null
        bgp_session_range               = ""
        ike_version                     = 2
        vpn_gateway_interface           = 1
        peer_external_gateway_interface = 3
        shared_secret                   = "" #secret_key_phrase3
      }
    }
  },
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Default Region | `any` | n/a | yes |
| <a name="input_vpn_ha"></a> [vpn\_ha](#input\_vpn\_ha) | The list of the service projets backend bucket names. | <pre>map(object({<br>    project_id = string<br>    region     = string<br>    vpc_name   = string<br>    # name       = string<br>    router_asn = number<br>    /* To create the IP address of the Cloud VPN Gateway, comment on the lines below and execute the Terraform code.<br>  Next, after obtaining VPN configuration data from AWS, fill the fields, remove the comments from the lines below, and execute the Terraform code once again. */<br>    peer_external_gateway = object({<br>      redundancy_type = string<br>      interfaces = list(object({<br>        id         = number<br>        ip_address = string<br>      }))<br>    })<br>    tunnels = map(object({<br>      bgp_peer = object({<br>        address = string<br>        asn     = number<br>      })<br>      bgp_peer_options = object({<br>        advertise_groups    = list(string)<br>        advertise_ip_ranges = map(string)<br>        advertise_mode      = string<br>        route_priority      = number<br>      })<br>      bgp_session_range               = string<br>      ike_version                     = number<br>      vpn_gateway_interface           = number<br>      peer_external_gateway_interface = number<br>      shared_secret                   = string<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_name"></a> [vpn\_name](#output\_vpn\_name) | n/a |

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
├── providers.tf               // To specify infrastructure vendors.
├── backend.tf                // To create terraform backend state configuration.

