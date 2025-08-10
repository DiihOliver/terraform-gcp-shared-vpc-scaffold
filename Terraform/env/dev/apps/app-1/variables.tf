variable "host_project_id" {
  type = string
}


variable "service_project_id" {
  type = string
}

variable "cloudflare_api_token_secret_name" {
  type        = string
  description = "The name of the GCP Secret Manager secret containing the Cloudflare API token."
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone id"
}

/******************************************
    Artifactory Repository Variables
 *****************************************/

variable "repo" {
  description = "The details of the Artifact Registries"
  type = map(object({
    repo_name      = string,
    region         = string,
    format         = string,
    description    = string,
    labels         = map(string),
    immutable_tags = bool,
    cleanup_policies = optional(map(object({
      action = optional(string)
      condition = optional(object({
        tag_state             = optional(string)
        tag_prefixes          = optional(list(string))
        version_name_prefixes = optional(list(string))
        package_name_prefixes = optional(list(string))
        older_than            = optional(string)
        newer_than            = optional(string)
      }), null)
      most_recent_versions = optional(object({
        package_name_prefixes = optional(list(string))
        keep_count            = optional(number)
      }), null)
    })))
  }))
}

variable "service_account_configs" {
  description = "A map of configurations for service accounts, their custom roles, and IAM bindings."
  type = map(object({
    service_account_name = string
    project_level_roles  = list(string)
    custom_role_id          = optional(string)
    custom_role_permissions = optional(list(string), [])
  }))
  default = {}
}

variable "cloud_run" {
  description = "The details of the Cloud Run"
  type = map(object({
    service_name                  = string,
    location                      = string,
    create_service_account        = bool,
    service_account               = string,
    cloud_run_deletion_protection = optional(bool),
    ingress                       = string,
    service_labels                = map(string),
    vpc_access = optional(object({
      connector = optional(string)
      egress    = optional(string)
      network_interfaces = optional(object({
        network    = optional(string)
        subnetwork = optional(string)
        tags       = optional(list(string))
      }))
    })),
    volumes = optional(list(object({
      name = string
      secret = optional(object({
        secret       = string
        default_mode = optional(string)
        items = optional(object({
          path    = string
          version = optional(string)
          mode    = optional(string)
        }))
      }))
      cloud_sql_instance = optional(object({
        instances = optional(list(string))
      }))
      empty_dir = optional(object({
        medium     = optional(string)
        size_limit = optional(string)
      }))
      gcs = optional(object({
        bucket    = string
        read_only = optional(string)
      }))
      nfs = optional(object({
        server    = string
        path      = string
        read_only = optional(string)
      }))
    })),[])
    containers = list(object({
      container_name       = optional(string, null)
      container_image      = string
      working_dir          = optional(string, null)
      depends_on_container = optional(list(string), null)
      container_args       = optional(list(string), null)
      container_command    = optional(list(string), null)
      env_vars             = optional(map(string), {})
      env_secret_vars = optional(map(object({
        secret  = string
        version = string
      })), {})
      volume_mounts = optional(list(object({
        name       = string
        mount_path = string
      })), [])
      ports = optional(object({
        name           = optional(string)
        container_port = optional(number)
      }), {})
      resources = optional(object({
        limits = optional(object({
          cpu    = optional(string)
          memory = optional(string)
        }))
        cpu_idle          = optional(bool, true)
        startup_cpu_boost = optional(bool, false)
      }), {})
      startup_probe = optional(object({
        failure_threshold     = optional(number, null)
        initial_delay_seconds = optional(number, null)
        timeout_seconds       = optional(number, null)
        period_seconds        = optional(number, null)
        http_get = optional(object({
          path = optional(string)
          port = optional(string)
          http_headers = optional(list(object({
            name  = string
            value = string
          })), [])
        }), null)
        tcp_socket = optional(object({
          port = optional(number)
        }), null)
        grpc = optional(object({
          port    = optional(number)
          service = optional(string)
        }), null)
      }), null)
      liveness_probe = optional(object({
        failure_threshold     = optional(number, null)
        initial_delay_seconds = optional(number, null)
        timeout_seconds       = optional(number, null)
        period_seconds        = optional(number, null)
        http_get = optional(object({
          path = optional(string)
          port = optional(string)
          http_headers = optional(list(object({
            name  = string
            value = string
          })), null)
        }), null)
        tcp_socket = optional(object({
          port = optional(number)
        }), null)
        grpc = optional(object({
          port    = optional(number)
          service = optional(string)
        }), null)
      }), null)
    }))
    max_instance_request_concurrency = optional(string, "80"),
    scaling = object({
      min_instance_count = optional(number, 1)
      max_instance_count = optional(number, 5)
    })
  }))
}

/******************************************
  Serverless NEG config Variables
*****************************************/

variable "region" {
  description = "The GCP region where the Serverless NEGs will be created."
  type        = string
}

variable "neg-name" {
  description = "A base name to use as a prefix for all created Serverless NEGs."
  type        = string
  default     = ""
}

variable "serverless_negs" {
  description = "A map of Serverless NEGs to create. Each key is a unique suffix for the NEG name, and the value contains a list of Cloud Run services to attach."
  type = map(object({
    cloud_run_services = list(string)
  }))
  default = {}
}

/******************************************
  Google Managed certificate Variables
*****************************************/

variable "location" {
  type        = string
  description = "The location for the certificate resources. Must be 'global'."
  default     = "global"
}

variable "certificate_name" {
  type        = string
  description = "A unique name for the certificate resource (e.g., 'my-prod-cert')."
}

variable "int_certificates" {
  description = "A map of certificate configurations, where the key is the desired certificate name and the value contains the domain and description."
  type = map(object({
    domain_name = string
    description = optional(string, "Managed by Terraform")
  }))
  default = {}
}


variable "certificate_description" {
  type        = string
  description = "An optional description for the certificate."
  default     = "Google Managed Certificate with DNS Authorization"
}

variable "domain_names" {
  type        = list(string)
  description = "A list of domain names to secure with the certificate."
}

/******************************************
  Ext-Load Balancers Variables
*****************************************/

variable "prefix" {
  type        = string
  description = "A prefix used for naming resources (e.g., 'dev', 'prod')."
}

variable "name" {
  type        = string
  description = "A unique name for the load balancer instance."
}

variable "domain" {
  type        = string
  description = "The domain name for the Google-managed SSL certificate (e.g., 'com')."
}

variable "certificate_map_name" {
  description = "The name for the Certificate Map."
  type        = string
}

variable "certificate_map_description" {
  description = "A description for the Certificate Map."
  type        = string
  default     = "Certificate map for the load balancer"
}

variable "backend_config" {
  type = object({
    neg_name = string
    region   = string
  })
  description = "Configuration for the Serverless NEG backend in the Service Project."
}

variable "routing_rules" {
  description = "A list of routing rules for host and path-based redirects."
  type = list(object({
    hostnames = list(string)
    path_redirects = list(object({
      source_paths  = list(string)
      redirect_path = string
    }))
  }))
  default = []
}

/******************************************
  Int-Load Balancers Variables
*****************************************/
variable "backends" {
  description = "A map of backend services to create. The key is a logical name used in routing_rules."
  type = map(object({
    service_project_id  = optional(string)
    serverless_neg_name = string
    log_config = optional(object({
      enable      = bool
      sample_rate = number
      }), {
      enable      = false
      sample_rate = 1.0
    })
  }))
}

variable "int_lb_routing_rules" {
  description = "A list of host rules and their associated path matching rules."
  type = list(object({
    hosts        = list(string)
    path_matcher = string
    paths = list(object({
      paths   = list(string)
      backend = optional(string)
      redirect = optional(object({
        path_redirect          = string
        redirect_response_code = optional(string, "MOVED_PERMANENTLY_DEFAULT")
        strip_query            = optional(bool, false)
      }))
    }))
  }))
  default = []
}

variable "int_lb_name" {
  description = "A unique name for the load balancer and its resources."
  type        = string
}


variable "network_name" {
  description = "The name of the Shared VPC network."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet for the load balancer's internal IP address."
  type        = string
}

variable "proxy_subnet_name" {
  description = "The name of the regional proxy-only subnet."
  type        = string
}

variable "labels" {
  description = "A map of labels to apply to the forwarding rules."
  type        = map(string)
  default     = {}
}
