/******************************************
  Details of app-03 Artifact Repository
 *****************************************/

service_project_id = "<service-project-id>"
cloudflare_api_token_secret_name = "<secret-name>"
cloudflare_zone_id               = "<zone-id>"

repo = {
  repo_01 = {
    repo_name   = "dev-us-central1-app-03-gar"
    region      = "us-central1"
    format      = "DOCKER"
    description = "For Docker Images"
    labels = {
      environment = "dev",
      purpose     = "app-03",
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
  app-03 = {
    service_account_name    = "app-03"
    custom_role_id          = "app_03_role"
    custom_role_permissions = ["storage.objects.get", "storage.objects.list"]
    project_level_roles     = ["roles/secretmanager.secretAccessor", "projects/<service-project-id>/roles/app_03_role"]
  }
}

cloud_run = {
  "app-03" = {
    service_name                  = "dev-app-03-us-central1-cr"
    location                      = "us-central1"
    create_service_account        = false
    service_account               = "app-03@<service-project-id>.iam.gserviceaccount.com"
    cloud_run_deletion_protection = true
    ingress                       = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
    service_labels = {
      env     = "dev"
      purpose = "app-03"
    }
    containers = [
      {
        container_image = "us-central1-docker.pkg.dev/<service-project-id>/dev-us-central1-app-03-gar/app-03:1.0.0"
        container_name  = "app-03"
        ports = {
          container_port = 8080
          name           = "http1"
        }
            env_vars = {
          "ENVIRONMENT_PROVIDER" = "GCP"
          "GCP_PROJECT_ID"       = "<service-project-id>"
        }
          env_secret_vars = {
          "ENV_SECRETS" = {
            secret  = "app-03-secrets"
            version = "latest"
          }
        }
        startup_probe = {
          initial_delay_seconds = 10
          timeout_seconds       = 240
          period_seconds        = 240
          failure_threshold     = 1
          tcp_socket ={
            port         = 8080
          }
        }
        liveness_probe = {
          initial_delay_seconds = 10
          timeout_seconds       = 2
          period_seconds        = 15
          failure_threshold     = 3
          http_get = {
            path         = "/_healthz"
            port         = 8080
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
neg-name = "dev-app-03-us-central1-neg"

serverless_negs = {
  "dev-app-03-us-central1-neg" = {                         # names might changes as per the naming for the load balancers and cloud run services
    cloud_run_services = ["dev-app-03-us-central1-cr"] # supply respective cloud run services
  },
}

# ----------------------------------------------------
# Google ext-certs ---
# ----------------------------------------------------
host_project_id  = "<host-project-id>"
certificate_name = "dev-app-03-cert"
domain_names = [
  "app-03-sample.com",
]
location = "global"

# ------------------------------------------------------------------
# Ext-Load Balancer configurations
# ------------------------------------------------------------------

prefix               = "dev"
name                 = "app-03"
domain               = "app-03-sample.com"
certificate_map_name = "dev-app-03-cert-map"
backend_config = {
  neg_name = "dev-app-03-us-central1-neg"
  region   = "us-central1"
}

routing_rules = [
  {
    hostnames = ["app-03-sample.com"] # Replace with actural path and hostnames
    path_redirects = [
      {
        source_paths  = ["/"]
        redirect_path = ""
      },
    ]
  },
]
