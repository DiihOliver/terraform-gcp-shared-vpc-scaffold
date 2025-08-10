/******************************************
  Details of GCP Private DNS Hosted Zone
 *****************************************/

host_project_id = "<host-project-id>"
svc_project_id = "<service-project-id>"
vpc_name   = "dev-main-vpc-01"

redis_dns_config = {
  redis-dev = {
    redis_dns_name     = "bots-staging-redis.com."
    redis_ipv4_address = "<ip-address>"
  },
  postgresql-dev = {
    postgresql_dns_name     = "bots-staging-redis.com."
    postgresql_ipv4_address = "<ip-address>"
  },

}