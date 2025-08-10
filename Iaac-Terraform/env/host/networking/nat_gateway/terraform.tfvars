project_id = "<host-project-id>"

nat_gateway = {
  nat_01 = {
    project_id   = "<host-project-id>"
    region       = "us-central1"
    vpc_name     = "dev-main-vpc-01"
    nat_name     = "dev-01-us-central1-nat"
    router_name  = "dev-01-us-central1-cr"
    address_name = "dev-natgw-us-central1-01-ext-ip"
  },
  nat_02 = {
    project_id   = "<host-project-id>"
    region       = "us-central1"
    vpc_name     = "prod-main-vpc"
    nat_name     = "prod-01-us-central1-nat"
    router_name  = "prod-01-us-central1-cr"
    address_name = "prod-natgw-us-central1-01-ext-ip"
  },
}



