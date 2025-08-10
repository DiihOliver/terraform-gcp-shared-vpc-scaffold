host_project_id     = "<host-project-id>"
service_project_ids = ["<service-project-id>", "<prod-service-project>", ]

# Service Project Networking
# These VPCs will be created in the host_project_id.

svc_project_networking = {
  # /******************************************
  #           Dev Environment VPC
  # *****************************************/ 
  dev-main-vpc-01 = {
    network_name = "dev-main-vpc-01"
    routing_mode = "GLOBAL"
    subnets = [
      {
        subnet_name           = "dev-mgmt-pvt-us-central1-subnet"
        subnet_cidr           = "10.1.0.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "dev-vpc-access-pvt-us-central1-subnet"
        subnet_cidr           = "10.1.16.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "dev-proxy-us-central1-subnet"
        subnet_cidr           = "10.1.128.0/22"
        subnet_region         = "us-central1"
        purpose               = "REGIONAL_MANAGED_PROXY"
        subnet_private_access = "false"
        subnet_flow_logs      = "false"
        role                  = "ACTIVE"
      },
      {
        subnet_name           = "dev-postgres-pvt-us-central1-subnet"
        subnet_cidr           = "10.1.48.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "dev-gke-pvt-us-central1-subnet"
        subnet_cidr           = "10.1.64.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      }
    ]
    secondary_ranges = {
      dev-gke-pvt-us-central1-subnet = [
        {
          range_name    = "dev-gke-pod-range"
          ip_cidr_range = "10.1.80.0/20"
        },
        {
          range_name    = "dev-gke-svc-range"
          ip_cidr_range = "10.1.96.0/20"
        }
      ]
    }
  },
  # /******************************************
  #           Prod US Environment VPC
  # *****************************************/
  prod-main-vpc = {
    network_name = "prod-main-vpc"
    routing_mode = "GLOBAL"
    subnets = [
      {
        subnet_name           = "prod-mgmt-pvt-us-central1-subnet"
        subnet_cidr           = "10.2.0.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "prod-vpc-access-pvt-us-central1-subnet"
        subnet_cidr           = "10.2.16.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "prod-postgres-pvt-us-central1-subnet"
        subnet_cidr           = "10.2.48.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "prod-gke-pvt-us-central1-subnet"
        subnet_cidr           = "10.2.64.0/20"
        subnet_region         = "us-central1"
        purpose               = null
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
      },
      {
        subnet_name           = "prod-proxy-us-central1-subnet"
        subnet_cidr           = "10.2.128.0/22"
        subnet_region         = "us-central1"
        purpose               = "REGIONAL_MANAGED_PROXY"
        subnet_private_access = "false"
        subnet_flow_logs      = "false"
        role                  = "ACTIVE"
      },
    ]
    secondary_ranges = {
      prod-gke-pvt-us-central1-subnet = [
        {
          range_name    = "prod-gke-pod-range"
          ip_cidr_range = "10.2.80.0/20"
        },
        {
          range_name    = "prod-gke-svc-range"
          ip_cidr_range = "10.2.96.0/20"
        }
      ]
    }
  },
}