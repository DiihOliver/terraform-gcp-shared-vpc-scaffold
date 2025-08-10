host_project_id                  = "<host-project-id>"
cloudflare_api_token_secret_name = "<secret-name>"
cloudflare_zone_id               = "<zone-id>"

/******************************************
  Details of Artifact Repository
 *****************************************/

service_project_id = "<service-project-id>"

repo = {
  repo_01 = {
    repo_name   = "dev-us-central1-app-02-gar"
    region      = "us-central1"
    format      = "DOCKER"
    description = "For Docker Images"
    labels = {
      environment = "dev",
      purpose     = "app-02",
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
          tag_prefixes = ["main","master"]
          older_than   = "30d"
        }
      },
      "policy_3" = {
        action = "KEEP",
        condition = {
          tag_state  = "TAGGED",
          tag_prefixes = ["dev","staging","production","v"]
        }
      }
    }
  }
}

service_account_configs = {
  app-02 = {
    service_account_name    = "app-02"
    custom_role_id          = "app-02_role"
    custom_role_permissions = ["storage.objects.get", "storage.objects.list"]
    project_level_roles     = ["roles/secretmanager.secretAccessor", "projects/<service-project-id>/roles/app-02_role"]
  }
}

cloud_run = {
  "app-02" = {
    service_name                  = "dev-app-02-us-central1-cr"
    location                      = "us-central1"
    create_service_account        = false
    service_account               = "app-02@<service-project-id>.iam.gserviceaccount.com"
    cloud_run_deletion_protection = false
    ingress                       = "INGRESS_TRAFFIC_INTERNAL_ONLY"
    service_labels = {
      env     = "dev"
      purpose = "app-02"
    }
    volumes = [
      {
        name = "staging_app-02"
        secret = {
          secret = "staging_app-02"
          items = {
            path    = "staging_app-02.json"
            version = "latest"
          }
        }
      }
    ]
    vpc_access = {
      egress = "PRIVATE_RANGES_ONLY"
      network_interfaces = {
        network    = "projects/<host-project-id>/global/networks/dev-main-vpc-01"
        subnetwork = "projects/<host-project-id>/regions/us-central1/subnetworks/dev-vpc-access-pvt-us-central1-subnet"
      }
    }
    containers = [
      {
        container_image = "us-central1-docker.pkg.dev/<service-project-id>/dev-us-central1-app-02-gar/app-02:1.0.0"
        container_name  = "app-02"
        ports = {
          container_port = 9744
          name           = "http1"
        }
        env_vars = {
          "ENVIRONMENT_PROVIDER"   = "GCP"
          "ENV_SECRETS_CONFIG_DIR" = "<respective-directory>"
        }
        volume_mounts = [
          {
            name       = "staging_app-02"
            mount_path = "<respective-mount-path>"
          }
        ]

        startup_probe = {
          initial_delay_seconds = 30
          timeout_seconds       = 240
          period_seconds        = 240
          failure_threshold     = 1
          http_get = {
            path         = "/_statusz"
            port         = 9744
            http_headers = []
          }
        }
        liveness_probe = {
          nitial_delay_seconds = 30
          timeout_seconds      = 2
          period_seconds       = 15
          failure_threshold    = 3
          http_get = {
            path         = "/_healthz"
            port         = 9744
            http_headers = []
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
neg-name = "dev-app-02-us-central1-neg"

serverless_negs = {
  "dev-app-02-us-central1-neg" = {                     
    cloud_run_services = ["dev-app-02-us-central1-cr"] 
  },
}

# ----------------------------------------------------
# Google regional-int-certs ---
# ----------------------------------------------------
int_certificates = {
  "dev-app-02-us-central1-int-cert" = {
    domain_name = "app-02-sample.com"
    description = "Certificate for the app-02 internal domain"
  },
}

# ----------------------------------------------------
# Regional Internal Load Balancer configurations ---
# ----------------------------------------------------

int_lb_name = "dev-app-02-us-central1-int-lb"

network_name      = "dev-main-vpc-01"
subnet_name       = "dev-vpc-access-pvt-us-central1-subnet"
proxy_subnet_name = "dev-proxy-us-central1-subnet"

backends = {
  "dev-app-02-us-central1" = {
    serverless_neg_name = "dev-app-02-us-central1-neg"
    log_config = {
      enable      = false
      sample_rate = 1.0
    }
  },
}

int_lb_routing_rules = [
  {
    hosts        = ["app-02-sample.com"]
    path_matcher = "dev-app-02-us-central1-pm-01"
    paths = [
      {
        paths   = ["/*"]
        backend = "dev-app-02-us-central1"
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
