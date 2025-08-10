host_project_id                  = "<host-project-id>"
service_project_id               = "<service-project-id>"
cloudflare_api_token_secret_name = "<secret-name>"
cloudflare_zone_id               = "<zone-id>"

/******************************************
  Details of Artifact Repository
 *****************************************/

repo = {
  repo_01 = {
    repo_name   = "dev-us-central1-app-01-gar"
    region      = "us-central1"
    format      = "DOCKER"
    description = "For Docker Images"
    labels = {
      environment = "dev",
      purpose     = "app-01",
      region      = "us-central1"
    }
    immutable_tags = false,
    cleanup_policies = {
      "policy_1" = {
        action = "DELETE",
        condition = {
          tag_state  = "UNTAGGED",
          older_than = "7d"
        }
      },
      "policy_2" = {
        action = "DELETE",
        condition = {
          tag_state    = "TAGGED",
          tag_prefixes = ["main", "master"]
          older_than   = "30d"
        }
      },
      "policy_3" = {
        action = "KEEP",
        condition = {
          tag_state    = "TAGGED",
          tag_prefixes = ["dev", "staging", "production", "v"]
        }
      }
    }
  }
}

service_account_configs = {
  app-01 = {
    service_account_name    = "app-01"
    custom_role_id          = "app_01_role"
    custom_role_permissions = ["storage.objects.get", "storage.objects.list"]
    project_level_roles     = ["roles/secretmanager.secretAccessor", "roles/storage.objectUser", "projects/<service-project-id>/roles/app_01_role"]
  }
}

cloud_run = {
  "app-01" = {
    service_name                  = "dev-app-01-us-central1-cr"
    location                      = "us-central1"
    create_service_account        = false
    service_account               = "app-01@<service-project-id>.iam.gserviceaccount.com"
    cloud_run_deletion_protection = true
    ingress                       = "INGRESS_TRAFFIC_INTERNAL_ONLY"
    service_labels = {
      env     = "dev"
      purpose = "app-01"
    }
    vpc_access = {                   # This need to be added only for the services with private internal connectivity
      egress = "PRIVATE_RANGES_ONLY" #  or "ALL_TRAFFIC"
      network_interfaces = {
        network    = "projects/<host-project-id>/global/networks/dev-main-vpc-01"
        subnetwork = "projects/<host-project-id>/regions/us-central1/subnetworks/dev-vpc-access-pvt-us-central1-subnet"
      }
    }
    containers = [
      {
        container_image = "us-central1-docker.pkg.dev/<service-project-id>/dev-us-central1-app-01-gar/app-01:1.0.0"
        container_name  = "app-01"
        ports = {
          container_port = 9733
          name           = "http1"
        }
        env_vars = {
          "ENVIRONMENT_PROVIDER" = "GCP"
          "GCP_PROJECT_ID"       = "<service-project-id>"
        }
        env_secret_vars = {
          "ENV_SECRETS" = {
            secret  = "staging_app-01"
            version = "latest"
          },
        }
        startup_probe = {
          initial_delay_seconds = 10
          timeout_seconds       = 3
          period_seconds        = 10
          failure_threshold     = 3
          tcp_socket = {
            port = 9733
          }
        }
      }
    ]
    max_instance_request_concurrency = "80"
    scaling = {
      min_instance_count = 1
      max_instance_count = 5
    }
  }
}

# ------------------------------------------------------------------
# Serverless Neg configurations
# ------------------------------------------------------------------

region   = "us-central1"
neg-name = "dev-app-01-us-central1-neg"

serverless_negs = {
  "app-01-us-central1-neg" = {                         # names might changes as per the naming for the load balancers and cloud run services
    cloud_run_services = ["dev-app-01-us-central1-cr"] # supply respective cloud run services
  },
}

# ----------------------------------------------------
# Google ext-certs ---
# ----------------------------------------------------
certificate_name = "dev-app-01-cert"
domain_names = [
  "app-01-sample.com",
]
location = "global"

# ----------------------------------------------------
# Google regional-int-certs ---
# ----------------------------------------------------

int_certificates = {
  "dev-us-central1-app-01-int-cert" = {
    domain_name = "app-01-sample.com"
    # description = "Certificate for the internal domain"
  },
}
# ----------------------------------------------------
# Regional Internal Load Balancer configurations ---
# ----------------------------------------------------

int_lb_name = "dev-us-central1-app-01-int-lb"

network_name      = "dev-main-vpc-01"
subnet_name       = "dev-vpc-access-pvt-us-central1-subnet"
proxy_subnet_name = "dev-proxy-us-central1-subnet"

backends = {
  "dev-us-central1-app-01" = {
    serverless_neg_name = "dev-app-01-us-central1-neg"
    log_config = {
      enable      = false
      sample_rate = 1.0
    }
  },
}

int_lb_routing_rules = [
  {
    hosts        = ["app-01-sample.com"]
    path_matcher = "dev-us-central1-app-01-pm"
    paths = [
      {
        paths   = ["/*"]
        backend = "dev-us-central1-app-01"
      },
      # {
      #   paths = ["", ""]
      #   redirect = {
      #     path_redirect = ""
      #   }
      # }
    ]
  },
]
labels = {
  environment = "dev"
}
# ------------------------------------------------------------------
# Ext-Load Balancer configurations
# ------------------------------------------------------------------

prefix               = "dev"
name                 = "app-01"
domain               = "app-01-sample.com"
certificate_map_name = "dev-app-01-cert-map"
backend_config = {
  neg_name = "dev-app-01-us-central1-neg"
  region   = "us-central1"
}

routing_rules = [
  {
    hostnames = ["app-01-sample.com"] # Replace with actural path and hostnames
    path_redirects = [
      {
        source_paths  = ["/"]
        redirect_path = ""
      },
    ]
  }
]
