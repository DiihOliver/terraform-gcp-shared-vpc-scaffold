variable "project_id" {
  type = string
}
variable "nat_gateway" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    project_id                         = string,
    region                             = string,
    vpc_name                           = string,
    nat_name                           = string,
    router_name                        = string,
    address_name                       = string,
    min_ports_per_vm                   = optional(string),
    icmp_idle_timeout_sec              = optional(string),
    tcp_established_idle_timeout_sec   = optional(string),
    tcp_transitory_idle_timeout_sec    = optional(string),
    udp_idle_timeout_sec               = optional(string)
  }))
  default = {
    def = {
      project_id                         = ""
      region                             = ""
      router_name                        = ""
      nat_name                           = ""
      vpc_name                           = ""
      address_name                       = ""
      min_ports_per_vm                   = "128"
      icmp_idle_timeout_sec              = "15"
      tcp_established_idle_timeout_sec   = "600"
      tcp_transitory_idle_timeout_sec    = "15"
      udp_idle_timeout_sec               = "15"
    }
  }
}
