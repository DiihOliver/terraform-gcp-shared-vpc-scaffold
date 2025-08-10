project_id = "<host-project-id>"
psa_config = {
  "psa-01" = {
    project_id         = "<host-project-id>"
    psa_name           = "dev-sql-01-psa"
    vpc_network        = "dev-main-vpc-01"
    vpc_address        = "10.1.120.0"
    prefix_length      = 22
    # Add this line and set to true for the first entry of the VPC
    create_connection  = true
  },
  "psa-02" = {
    project_id         = "<host-project-id>"
    psa_name           = "dev-redis-01-psa"
    vpc_network        = "dev-main-vpc-01"
    vpc_address        = "10.1.124.0"
    prefix_length      = 22
    # Add this line and set to false for subsequent entries for the same VPC
    create_connection  = false
  },
  "psa-03" = {
    project_id    = "<host-project-id>"
    psa_name      = "prod-sql-01-psa"
    vpc_network   = "prod-main-vpc"
    vpc_address   = "10.2.120.0" #please provide the internal IP which is NOT in range with the subnet CIDR
    prefix_length = "22"
    create_connection  = true
  },
  "psa-04" = {
    project_id    = "<host-project-id>"
    psa_name      = "prod-redis-01-psa"
    vpc_network   = "prod-main-vpc"
    vpc_address   = "10.2.124.0" #please provide the internal IP which is NOT in range with the subnet CIDR
    prefix_length = "22"
    create_connection  = false
  },
}
